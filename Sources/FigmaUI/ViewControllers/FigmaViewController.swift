import UIKit

public final class FigmaViewController: UIViewController {
    
    private let apiKey: String
    
    private let documentId: String
    
    private let rootView: (FigmaDocument.DocumentView) -> (any FigmaUI.View)?
    
    private let designSystem: FigmaUI.FigmaDesignSystem
    
    // MARK: Inits
    
    public init(
        apiKey: String,
        documentId: String,
        designSystem: FigmaDesignSystem,
        rootView: @escaping (FigmaDocument.DocumentView) -> (any FigmaUI.View)?
    ) {
        self.documentId = documentId
        self.rootView = rootView
        self.apiKey = apiKey
        self.designSystem = designSystem
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                try await loadFigmaFile()
            } catch {
                print(error)
            }
        }
    }
    
}

private extension FigmaViewController {
    
    func loadFigmaFile() async throws {
        let documentUrl = URL(string: "https://api.figma.com/v1/files/\(documentId)")!
        var request = URLRequest(url: documentUrl)
        
        request.addValue(apiKey, forHTTPHeaderField: "X-FIGMA-TOKEN")
        
        let data = try await URLSession.shared.data(for: request).0
        let document = try JSONDecoder().decode(FigmaDocument.self, from: data)

        let view = rootView(document.document)?.layout(
            with: .empty,
            designSystem: designSystem
        )
        
        await MainActor.run {
            guard let view else { return }

            view.frame = self.view.bounds
            
            self.view.addSubview(view)
            self.view.layoutIfNeeded()
        }
    }
    
}
