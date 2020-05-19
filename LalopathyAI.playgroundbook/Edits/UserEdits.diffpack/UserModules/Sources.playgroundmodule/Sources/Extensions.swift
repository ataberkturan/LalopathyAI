import SwiftUI

// MARK: - Extensions

/// Reusable custom "easeIn" animations.
public extension View {
    func coolAnimate(using animation: Animation = Animation.easeIn(duration: 1), delayCount: Double, _ action: @escaping () -> Void) -> some View {
        let delay = animation.delay(delayCount)
        
        // Setting the animation action.
        return onAppear {
            withAnimation(delay) {
                action()
            }
        }
    }
}

/// Reusable custom "easeIn" animations.
public extension View {
    func bootUpAnimate(using animation: Animation = Animation.easeIn(duration: 3), delayCount: Double, _ action: @escaping () -> Void) -> some View {
        // Setting the animation delay.
        let delay = animation.delay(delayCount)
        
        // Setting the animation action.
        return onAppear {
            withAnimation(delay) {
                action()
            }
        }
    }
}

/// Reusable custom "asymmetric" transition.
public extension AnyTransition {
    static var pageTransition: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
}

