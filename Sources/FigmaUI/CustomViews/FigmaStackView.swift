import UIKit

final class FigmaStackView: UIStackView {
    
    private let frameView: FrameView
    
    private var lastStretchSubview: UIView?
    
    private let primaryMinStubView = UIView()
    
    private let primaryMaxStubView = UIView()
    
    init(frameView: FrameView) {
        self.frameView = frameView
        super.init(frame: .zero)
        
        axis = (frameView.layoutMode?.axis).rescue(.horizontal)
        spacing = (frameView.itemSpacing?.cgFloat).rescue(.zero)
        
        addArrangedSubview(primaryMinStubView)
        addArrangedSubview(primaryMaxStubView)
        
        switch (frameView.primaryAxisAlignItems, axis) {
        case (.max, _):
            primaryMaxStubView.isHidden = true
        case (.min, _):
            primaryMinStubView.isHidden = true
        case (.spaceBetween, _):
            primaryMinStubView.isHidden = true
            primaryMaxStubView.isHidden = true
            distribution = .equalSpacing
        case (.center, .horizontal):
            primaryMinStubView.widthAnchor
                .constraint(equalTo: primaryMaxStubView.widthAnchor)
                .isActive = true
        case (.center, .vertical):
            primaryMinStubView.heightAnchor
                .constraint(equalTo: primaryMaxStubView.heightAnchor)
                .isActive = true
        case (.none, _), (.some(.center), _):
            break
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addFigmaView(
        subview: View,
        with properties: FigmaLayoutProperties,
        designSystem: FigmaDesignSystem
    ) {
        let resultView: UIView
        
        if subview.layoutAlign == .inherit {
            let minStubView = UIView()
            let maxStubView = UIView()
            
            let wrappedStackView = UIStackView(arrangedSubviews: [
                minStubView,
                subview.layout(with: properties, designSystem: designSystem),
                maxStubView
            ])
            
            switch axis {
            case .horizontal:
                wrappedStackView.axis = .vertical
            case .vertical:
                wrappedStackView.axis = .horizontal
            @unknown default:
                assertionFailure("Unknown axis")
            }
            
            switch (frameView.counterAxisAlignItems, axis) {
            case (.min, _):
                minStubView.isHidden = true
            case (.max, _):
                maxStubView.isHidden = true
            case (.center, .horizontal):
                minStubView.heightAnchor
                    .constraint(equalTo: maxStubView.heightAnchor)
                    .isActive = true
            case (.center, .vertical):
                minStubView.widthAnchor
                    .constraint(equalTo: maxStubView.widthAnchor)
                    .isActive = true
            case (.none, _), (.some(.center), _):
                break
            }
            
            resultView = wrappedStackView
        } else {
            resultView = subview.layout(with: properties, designSystem: designSystem)
        }
        
        insertArrangedSubview(resultView, at: arrangedSubviews.count - 1)
        
        if subview.layoutGrow == .stretch {
            switch axis {
            case .horizontal:
                lastStretchSubview?
                    .widthAnchor
                    .constraint(equalTo: resultView.widthAnchor)
                    .isActive = true
            case .vertical:
                lastStretchSubview?
                    .heightAnchor
                    .constraint(equalTo: resultView.heightAnchor)
                    .isActive = true
            @unknown default:
                assertionFailure("Unknown axis")
            }
            
            primaryMaxStubView.isHidden = true
            primaryMinStubView.isHidden = true
            lastStretchSubview = resultView
        }
    }
    
}
