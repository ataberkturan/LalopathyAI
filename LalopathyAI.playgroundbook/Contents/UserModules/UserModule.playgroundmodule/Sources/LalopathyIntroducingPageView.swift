import SwiftUI

public struct LalopathyIntroducingPageView: View {
    
    // Controls the transition between pages.
    @EnvironmentObject var viewRouter : ViewRouter
    
    // Properties.
    var title: String
    var textSize: CGFloat
    var buttonTitle: String
    var nextPageIdentifier: Int
    var width: CGFloat
    var height: CGFloat
    
    // Variables that govern variable properties.
    @State var titleOpacity = 0.0
    @State var buttonOpacity = 0.0
    
    // Life Cycle.
    public init(title: String, textSize: CGFloat, buttonTitle: String, nextPageIdentifier: Int, width: CGFloat, height: CGFloat) {
        self.title = title
        self.textSize = textSize
        self.buttonTitle = buttonTitle
        self.nextPageIdentifier = nextPageIdentifier
        self.width = width
        self.height = height
    }
    
    public var body: some View {
        ZStack{
            /**
             Customized Animation
             - .bootUpAnimate: It is an "easeIn" animation.
             */
            
            // Background animation.
            EmitterView()
                .coolAnimate(delayCount: 0) {
                    self.titleOpacity = 1.0
            }
            
            VStack{
                GradientText(text: title, size: textSize, width: width, height: height)
                    .padding(5)
                    .opacity(titleOpacity)
                    .bootUpAnimate(delayCount: 0) {
                        self.titleOpacity = 1.0
                }
                
                Button(action: { 
                    self.viewRouter.currentPage = self.nextPageIdentifier
                }){
                    Text(buttonTitle)
                }
                .buttonStyle(LalopathyButtonStyle())
                .padding()
                .opacity(buttonOpacity)
                .bootUpAnimate(delayCount: 1) {
                    self.buttonOpacity = 1.0
                }
            }
        }
    }
}

