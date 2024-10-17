import AVFoundation

class SoundEngine: ObservableObject {
    let audioEngine: AVAudioEngine
    let audioPlayerNode: AVAudioPlayerNode
    let sampleRate: Float = 44100.0
    let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 1)!
    var buffer: AVAudioPCMBuffer!
    var lastFrequency: Float?
    @Published var isPlaying = false

    init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: format)
    }
    
    func generateSineWaveBuffer(frequency: Float) {
        let frameCount = AVAudioFrameCount(sampleRate/frequency)
        buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)
        if buffer != nil {
            buffer.frameLength = frameCount
            let theta = 2.0*Float.pi*frequency/sampleRate
            for frame in 0..<Int(frameCount) {
                buffer.floatChannelData!.pointee[frame] = sin(theta*Float(frame))
            }
            lastFrequency = frequency
        }
    }

    func play(frequency: Float) {
        if frequency != lastFrequency {
            generateSineWaveBuffer(frequency: frequency)
        }
        audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .loops)
        try! audioEngine.start()
        audioPlayerNode.play()
        isPlaying = true
    }

    func stop() {
        audioPlayerNode.stop()
        audioEngine.stop()
        isPlaying = false
    }
    
    func togglePlayPause(frequency: Float) {
        isPlaying ? stop() : play(frequency: frequency)
    }
    
    func updateFrequency(frequency: Float) {
        generateSineWaveBuffer(frequency: frequency)
        if isPlaying {
            self.stop()
            self.play(frequency: frequency)
        }
    }
}
