import Foundation
import AVFoundation
import Speech

@MainActor
final class SpeechRecognizer: NSObject, ObservableObject {
    @Published var transcript: String = ""
    @Published var isAuthorized: Bool = false
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer = SFSpeechRecognizer()
    
    override init() {
        super.init()
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async { [weak self] in
                self?.isAuthorized = (status == .authorized)
            }
        }
    }
    
    func start() throws {
        guard isAuthorized else { return }
        stop()
        transcript = ""
        let engine = AVAudioEngine()
        let request = SFSpeechAudioBufferRecognitionRequest()
        let input = engine.inputNode
        let format = input.outputFormat(forBus: 0)
        input.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            request.append(buffer)
        }
        engine.prepare()
        try engine.start()
        self.audioEngine = engine
        self.request = request
        self.task = recognizer?.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }
            if let text = result?.bestTranscription.formattedString { self.transcript = text }
            if result?.isFinal == true || error != nil { self.stop() }
        }
    }
    
    func stop() {
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        task?.cancel()
        audioEngine = nil
        request = nil
        task = nil
    }
}

