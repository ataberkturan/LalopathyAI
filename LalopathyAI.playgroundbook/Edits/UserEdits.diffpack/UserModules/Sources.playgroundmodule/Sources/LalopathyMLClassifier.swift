//
// LalopathyML.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML

/// Model Prediction Input Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class LalopathyMLInput : MLFeatureProvider {

    /// Input audio samples to be classified as 15600 element vector of floats
    public var audioSamples: MLMultiArray

    public var featureNames: Set<String> {
        get {
            return ["audioSamples"]
        }
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "audioSamples") {
            return MLFeatureValue(multiArray: audioSamples)
        }
        return nil
    }
    
    public init(audioSamples: MLMultiArray) {
        self.audioSamples = audioSamples
    }
}

/// Model Prediction Output Type
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class LalopathyMLOutput : MLFeatureProvider {

    /// Source provided by CoreML

    public let provider : MLFeatureProvider


    /// Probability of each category as dictionary of strings to doubles
    lazy var classLabelProbs: [String : Double] = {
        [unowned self] in return self.provider.featureValue(for: "classLabelProbs")!.dictionaryValue as! [String : Double]
    }()

    /// Most likely sound category as string value
    lazy var classLabel: String = {
        [unowned self] in return self.provider.featureValue(for: "classLabel")!.stringValue
    }()

    public var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    public func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    public init(classLabelProbs: [String : Double], classLabel: String) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["classLabelProbs" : MLFeatureValue(dictionary: classLabelProbs as [AnyHashable : NSNumber]), "classLabel" : MLFeatureValue(string: classLabel)])
    }

    public init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class LalopathyML {
    public var model: MLModel

/// URL of model assuming it was installed in the same bundle as this class
    public class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: LalopathyML.self)
        return bundle.url(forResource: "LalopathyML", withExtension:"mlmodelc")!
    }

    /**
        Construct a model with explicit path to mlmodelc file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    public init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    public convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration
        - parameters:
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    public convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct a model with explicit path to mlmodelc file and configuration
        - parameters:
           - url: the file url of the model
           - configuration: the desired model configuration
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL, configuration: MLModelConfiguration) throws {
        self.model = try MLModel(contentsOf: url, configuration: configuration)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as LalopathyMLInput
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as LalopathyMLOutput
    */
    func prediction(input: LalopathyMLInput) throws -> LalopathyMLOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as LalopathyMLInput
           - options: prediction options
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as LalopathyMLOutput
    */
    func prediction(input: LalopathyMLInput, options: MLPredictionOptions) throws -> LalopathyMLOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return LalopathyMLOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - audioSamples: Input audio samples to be classified as 15600 element vector of floats
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as LalopathyMLOutput
    */
    func prediction(audioSamples: MLMultiArray) throws -> LalopathyMLOutput {
        let input_ = LalopathyMLInput(audioSamples: audioSamples)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [LalopathyMLInput]
           - options: prediction options
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [LalopathyMLOutput]
    */
    func predictions(inputs: [LalopathyMLInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [LalopathyMLOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [LalopathyMLOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  LalopathyMLOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
