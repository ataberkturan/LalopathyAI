import SwiftUI
import Combine
import AVFoundation

public class AudioRecorder: ObservableObject {
    // To notify observing views about changes.
    public let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    // To control the recording sessions.
    public var audioRecorder: AVAudioRecorder!
    var audioFileName: URL!
    
    // Checking if the Voice Recorder is recording anything.
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    // To make the class public.
    public init(){}
    
    public func startRecording() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let documentName = UUID()
        audioFileName = documentPath.appendingPathComponent("\(documentName).m4a")
        
        // Recording settings.
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        // Starting the recording
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.record()
            
            // Update the recording status.
            recording = true
        } catch {
            print("Could not start recording \(error.localizedDescription)")
        }
    }
    
    public func stopRecording() {
        audioRecorder.stop()
        ClassificationProvider().predictionResult(audioFileUrl: audioFileName)
        recording = false
    }
}
