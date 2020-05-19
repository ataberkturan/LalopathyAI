
import CoreML
import SoundAnalysis
import AVKit

class ClassificationProvider : NSObject, SNResultsObserving {
    
    // MARK: - Functions
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        // Getting the top classification.
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }
        
        let confidence = classification.confidence * 100.0
        let percent = String(format: "%.0f", confidence)
        
        // Getting the LalopathyML result.
        let prediction = "Prediction: %\(percent) \(classification.identifier)"
        predictionText = prediction
    }
    
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("The the analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("The request completed successfully!")
    }
    
    public func predictionResult(audioFileUrl: URL) {
        var model: MLModel!  
        
        //Access the bundled CoreML model
        let soundClassifier = LalopathyML()      
        model = soundClassifier.model      
        
        do {
            // Creating a new audio file analyzer.
            let audioFileAnalyzer = try SNAudioFileAnalyzer(url: audioFileUrl)
            
            // Creating a new observer that will be notified of analysis results.
            let resultsObserver = ClassificationProvider()
            
            do {
                // Preparing a new request for the trained model.
                let request = try SNClassifySoundRequest(mlModel: model)
                try audioFileAnalyzer.add(request, withObserver: resultsObserver)
            } catch {
                print(error.localizedDescription)
            }
            audioFileAnalyzer.analyze()
        } catch {
            print(error.localizedDescription)
        }
        
    }
}




