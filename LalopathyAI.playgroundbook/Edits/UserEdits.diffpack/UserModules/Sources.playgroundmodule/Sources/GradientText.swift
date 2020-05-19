import SwiftUI

public struct GradientText: View {
    
    // Public variables.
    var text: String
    var size: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    // Initializing the public variables.
    public init(text: String, size: CGFloat, width: CGFloat, height: CGFloat) {
        self.text = text
        self.size = size
        self.width = width
        self.height = height
    }
    
    // Linear Gradient colors.
    var orangeColor = Color(UIColor(red: 1.00, green: 0.65, blue: 0.00, alpha: 1.00))
    var redColor = Color(UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1.00))
    
    public var body: some View  {
        
        // Masked custom text.
        LinearGradient(gradient: .init(colors: [orangeColor, redColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .mask(
                Text(text)
                    .font(.system(size: size, weight: .heavy, design: .default))
            ).frame(width: width, height: height, alignment: .leading)
    }
}
