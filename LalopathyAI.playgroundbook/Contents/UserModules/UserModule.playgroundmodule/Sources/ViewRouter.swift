import SwiftUI
import Combine

// This function allows to manage the transition between pages.
public class ViewRouter: ObservableObject {
    
    // To make the class public.
    public init() {}
    
    // We use the PasstroughObject to notify all views of the changes.
    public let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    // Setting the current page.
    public var currentPage: Int = 0 {
        didSet {
            // Wrapping the "WillChange" method into an animation function, made the transition between pages animated.
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
}


