//#-hidden-code
import SwiftUI
import Combine
import PlaygroundSupport



let titleArray = DataProvider().getData(dataName: "Titles")
let subtitleArray =  DataProvider().getData(dataName: "CatalogSubtitles")
let textArray =  DataProvider().getData(dataName: "CatalogTexts")
let imageArray =  DataProvider().getData(dataName: "CatalogImages")


let IntroducingView = LalopathyIntroducingPageView(title: titleArray[0], textSize: 120, buttonTitle: "Let's Start", nextPageIdentifier:1, width: 683, height: 150)

let WelcomeView = LalopathyCatalogPageView(title: titleArray[1], subtitle: subtitleArray[0], text: textArray[0], buttonText: "Continue", nextPageIdentifier: 2, image: UIImage(named: imageArray[0])!)

let WhatsLalopathyView = LalopathyInteractiveCatalogPageView(title: titleArray[2], subtitle: subtitleArray[1], text: textArray[1], buttonText: "Continue", nextPageIdentifier: 3)

let WhatsLalopathyAIView = LalopathyCatalogPageView(title: titleArray[3], subtitle: subtitleArray[1], text: textArray[2], buttonText: "Let's Try", nextPageIdentifier: 4, image: UIImage(named: imageArray[1])!)

let AIView = LalopathyAIPageView(audioRecorder: AudioRecorder(), title: titleArray[4], buttonText: "Continue", nextPageIdentifier: 5)

let TheEndView = LalopathyCatalogPageView(title: titleArray[5], subtitle: subtitleArray[2], text: textArray[3], buttonText: "Restart", nextPageIdentifier: 0, image: UIImage(named: imageArray[2])!)


struct LalopathyPageManager : View {
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body : some View {
        VStack{
            if viewRouter.currentPage == 0 {
                IntroducingView
            } else if viewRouter.currentPage == 1 {
                WelcomeView
                    .transition(.pageTransition)
            } else if viewRouter.currentPage == 2 {
                WhatsLalopathyView
                    .transition(.pageTransition)
            }  else if viewRouter.currentPage == 3 {
                WhatsLalopathyAIView
            } else if viewRouter.currentPage == 4 {
                AIView
            } else if viewRouter.currentPage == 5 {
                TheEndView
            }
        }
    }
}

let manager = LalopathyPageManager().environmentObject(ViewRouter())

let PageManager = UIHostingController(rootView: manager)
PageManager.view.backgroundColor = .black

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(PageManager)
//#-end-hidden-code

/*:
 
  !["Banner"](welcomeBanner.png)
 
  # Welcome to LalopathyAI
 
Lalopathy is the playground book project that I prepared is an interactive voice recorded by the user and try to detect speech disorder. It is also a tutorial playground book that explains what Lalopathy is step by step.
 
 
 Please wait for a few seconds for the playground book to start, and then, enjoy!😀
 
 
  - Important:
    Please run 'live view' at full-screen size.
 
 ---
 
 ## What is Lalopathy? 🤔
 
 “The Individuals with Disabilities Education Act (IDEA) officially defines Lalopathy as “a communication disorder such as stuttering, impaired articulation, a language impairment, or a voice impairment that adversely affects a child’s educational performance.” Each point within this official definition represents a speech and language subcategory. “A communication disorder such as stuttering” provides an example of a fluency disorder; other fluency issues include unusual word repetition and hesitant speech. ”
 
  ☝️ From [Special Education Guide](https://www.specialeducationguide.com/disability-profiles/speech-and-language-impairments/)
 
  ---
 
 ## Design ✨
 
  I designed this playground book by blending my imagination and the design of the WWDC20. The result was a very simple, stylish, and easy-to-understand playground book project.
 
  ---
 
 ## Technologies 🧑‍💻
 
 This playground book was made using the latest technologies such as SwiftUI, CoreML, CreateML, Combine. Thus, I was able to make a playground book project, the infrastructure of which is equipped with the most powerful technologies and compatible with future innovations.
 
  ---
 
 ## Creating and Training The Model 👩‍🏫
 
 The machine learning model used in this playground book was trained by me using 80 different sounds. I recorded these 80 different sounds with iPhone using AirPods.
 
 ---

 ## Credits and Thanks 🙏
 - [This article](https://bit.ly/2Zijm9I) helped me understand the logic of Lalopathy.
 - [BLCKBIRDS's](https://bit.ly/2WCRX0u) blog post helped me create the voice recorder in this playground.
 - [Sergen Gönenç](https://github.com/sergendev) for his [blog post](https://bit.ly/2LGo2y9) on how to add `.mlmodel` files to Swift Playground.
 
*/

//: # This playground book was made with great excitement, in 7 days, by Ataberk Turan!😊


