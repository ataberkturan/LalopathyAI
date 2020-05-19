
import SwiftUI

// MARK: - Functions

// Button Text Style.
public struct LalopathyButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 22, weight: .heavy, design: .default))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 15, leading: 60, bottom: 15, trailing: 60))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white, lineWidth: 2))
    }
}


