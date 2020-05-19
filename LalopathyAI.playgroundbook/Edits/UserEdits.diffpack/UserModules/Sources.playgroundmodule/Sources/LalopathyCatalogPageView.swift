import SwiftUI

public struct LalopathyCatalogPageView: View {
    
    // Controls the transition between pages.
    @EnvironmentObject var viewRouter : ViewRouter
    
    // Properties.
    var title: String
    var subtitle: String
    var text: String
    var buttonText: String
    var nextPageIdentifier: Int
    var image: UIImage
    
    // Life Cycle.
    public init(title: String, subtitle: String, text: String, buttonText: String, nextPageIdentifier: Int, image: UIImage){
        self.title = title
        self.subtitle = subtitle
        self.text = text
        self.buttonText = buttonText
        self.nextPageIdentifier = nextPageIdentifier
        self.image = image
    }
    // Variables that govern variable properties.
    @State var titleOpacity = 0.0
    @State var subTitleOpacity = 0.0
    @State var textOpacity = 0.0
    @State var buttonOpacity = 0.0
    @State var imageOpacity = 0.0
    
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 40){
                
                /**
                 Customized Animation
                 - .coolAnimate: It is an "easeIn" animation.
                 */
                
                GradientText(text: subtitle, size: 45, width: 660, height: 53)
                    .opacity(titleOpacity)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -40, trailing: 0))
                    .coolAnimate(delayCount: 0) {
                        self.titleOpacity = 1.0
                    }
                
                GradientText(text: title, size: 90, width: 660, height: 105)
                    .opacity(subTitleOpacity)
                    .coolAnimate(delayCount: 0) {
                        self.subTitleOpacity = 1.0
                    }
                
                Text(text)
                    .font(.system(size: 30, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .frame(width: 660, alignment: .leading)
                    .opacity(textOpacity)
                    .coolAnimate(delayCount: 1.0) {
                        self.textOpacity = 1.0
                }
                
                // Continue Button.
                Button(action: { 
                    self.viewRouter.currentPage = self.nextPageIdentifier
                }){
                    Text(buttonText)
                }
                .buttonStyle(LalopathyButtonStyle())
                .opacity(buttonOpacity)
                .coolAnimate(delayCount: 1.5) {
                    self.buttonOpacity = 1.0
                }
            }.padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
            
            Spacer()
            
            // Trailing image.
            Image(uiImage: image)
            .resizable()
                .frame(width: 405, height: 587, alignment: .trailing)
                .opacity(imageOpacity)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
                .coolAnimate(delayCount: 0) {
                    self.imageOpacity = 1.0
                }
        }
    }
}
