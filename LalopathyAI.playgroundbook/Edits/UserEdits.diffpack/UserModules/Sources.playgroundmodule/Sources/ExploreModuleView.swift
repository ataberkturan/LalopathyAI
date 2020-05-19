import SwiftUI

public struct ExploreModuleView: View {
    // Properties.
    var title: String
    var subtitle: String
    var voiceUrl: URL!
    var padding: EdgeInsets
    
    // Property for control the AudioPlayer.
    @ObservedObject var audioPlayer = AudioPlayer()
    
    // Life Cycle.
    public init(subtitle: String, title: String, voiceUrl: URL, padding: EdgeInsets){
        self.subtitle = subtitle
        self.title = title
        self.voiceUrl = voiceUrl
        self.padding = padding
    }
    
    public var body: some View {
        VStack{
            VStack(alignment: .leading){
                // Subtitle of module.
                Text(subtitle)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium, design: .default))
                // Title of module.
                Text(title)
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .medium, design: .default))
                
                // Customized button.
                Button(action: { 
                    if self.audioPlayer.isPlaying == false {
                        if let audioUrl = self.voiceUrl {
                            self.audioPlayer.startPlayback(audio: audioUrl)
                        }
                    }else {
                        self.audioPlayer.stopPlayback()
                    }
                }){
                    HStack{
                        // Text of button.
                        Text( audioPlayer.isPlaying ? "Pause" : "Play")
                            .font(.system(size: 25, weight: .bold, design: .default))
                            .foregroundColor(.black)
                        // Image of button.
                        Image(uiImage:  audioPlayer.isPlaying ? UIImage(named: "pauseIcon.png")! : UIImage(named: "playIcon.png")!)
                            .resizable()
                            .frame(width: 24, height: 30)
                            .foregroundColor(.black)
                    }
                    .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                    .background(Color.white)
                    .cornerRadius(20)
                }
                
                Text("This sound was recorded by me.")
                    .foregroundColor(.gray)
                    .font(.system(size: 15, weight: .medium, design: .default))
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            }
            .padding(padding)
        }
        .background(Color.init(red: 0.12, green: 0.12, blue: 0.12))
        .cornerRadius(40)
    }
}
