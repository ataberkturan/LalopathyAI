import SwiftUI

public struct EmitterView: UIViewRepresentable {
    
    // MARK: - Functions
    
    /// EmitterView layer creation function.
    public func particlesLayer(size: CGSize) -> CAEmitterLayer{
        // Layer identification.
        let particlesLayer = CAEmitterLayer()
        
        // Setting the layer properties.
        particlesLayer.backgroundColor = UIColor.white.cgColor
        particlesLayer.emitterShape = .circle
        particlesLayer.emitterPosition = CGPoint(x: 0, y: 0)
        particlesLayer.emitterSize = size
        particlesLayer.emitterMode = .surface
        particlesLayer.renderMode = .oldestLast
        
        return particlesLayer
    }
    
    /// The function that creates the "UIView" layer with the "CAEmitterLayer" layer.
    public func makeUIView(context: Context) -> UIView {
        // Properties
        let size = UIScreen.main.bounds
        let hostView = UIView()
        let emitterLayer = particlesLayer(size: CGSize(width: size.width*4, height: size.height))
        
        hostView.layer.addSublayer(emitterLayer)
        hostView.layer.masksToBounds = true
        
        // Getting the images from jSON file.
        let imageNames = DataProvider().getData(dataName: "Memojies")
        let images = imageNames.compactMap {( UIImage(named: $0)?.cgImage)}
        
        let cells = images.compactMap {( $0 )}.map{( cell(content: $0) )}
        
        // EmitterLayer cells definition.
        emitterLayer.emitterCells = cells
        
        return hostView
    }
    
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<EmitterView>) {
    }
    
    public typealias UIViewType = UIView
}
