import SwiftUI

// Text changes according to the state of ML model.
public var predictionText = "Tap to '􀊰' button!"

// Reusable custom page.
public struct LalopathyAIPageView: View {
    
    // Property for checking AudioRecorder status.
    @ObservedObject public var audioRecorder: AudioRecorder
    
    // Controls the transition between pages.
    @EnvironmentObject var viewRouter : ViewRouter
    
    // Properties.
    var title: String
    var buttonText: String
    var nextPageIdentifier: Int
    
    // Life Cycle.
    public init(audioRecorder: AudioRecorder, title: String, buttonText: String, nextPageIdentifier: Int) {
        self.audioRecorder = audioRecorder
        self.title = title
        self.buttonText = buttonText
        self.nextPageIdentifier = nextPageIdentifier
    }
    
    // Variables that govern variable properties.
    @State var titleOpacity = 0.0
    @State var textOpacity = 0.0
    @State var microphoneOpacity = 0.0
    @State var buttonOpacity = 0.0
    @State var stopText = false
    @State var continueButton = false
    
    public var body: some View {
        VStack{
            
            /**
             Customized Animation
             - .coolAnimate: It is an "easeIn" animation
             */
            
            GradientText(text: title, size: 90, width: 680, height: 110)
                .opacity(titleOpacity)
                .coolAnimate(delayCount: 0) {
                    self.titleOpacity = 1.0
            }
                
            Text(predictionText)
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(.white)
                .frame(width: 680, alignment: .center)
                .opacity(textOpacity)
                .coolAnimate(delayCount: 0.5) {
                    self.textOpacity = 1.0
            }
            
            if self.stopText == true {
                Text("Tap '􀊱' to stop!")
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    .foregroundColor(.gray)
                    .frame(width: 680, alignment: .center)
            }
            
            // Microphone button.
            Button(action: {
                    
                // Check the AudioRecorder status.
                if self.audioRecorder.recording == false {
                    self.audioRecorder.startRecording()
                    self.stopText = true
                    predictionText = "Listening..."
                } else {
                    self.audioRecorder.stopRecording()
                    self.stopText = false
                    self.continueButton = true
                }
                    
            }){
                // Button icon.
                Image(uiImage: audioRecorder.recording ? UIImage(named: "stopMicrophoneIcon.png")! : UIImage(named: "microphoneIcon.png")!)
                    .resizable()
                    .frame(width: 200, height: 215, alignment:
                        .center)
            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 25, leading: 0, bottom: 55, trailing: 0))
            .opacity(microphoneOpacity)
            .coolAnimate(delayCount: 1) {
                self.microphoneOpacity = 1.0
            }
            
            if self.continueButton == true{
                // Continue Button.
                Button(action: { 
                    self.viewRouter.currentPage = self.nextPageIdentifier
                    predictionText = "Tap to '􀊰' button!"
                }){
                    Text(buttonText)
                }
                .buttonStyle(LalopathyButtonStyle())
                .opacity(buttonOpacity)
                .coolAnimate(delayCount: 0.5) {
                    self.buttonOpacity = 1.0
                }
            }
        }
    }
}


