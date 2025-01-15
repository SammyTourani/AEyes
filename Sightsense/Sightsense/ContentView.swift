import SwiftUI
import AVFoundation

enum AppFlowState {
    case loading
    case welcome      // "Tap to get started"
    case permissions  // Camera & mic permission
    case tutorial     // 2-minute voice tutorial
    case home         // Final home page with voice interface
}

struct ContentView: View {
    @State private var flowState: AppFlowState = .loading

    // We’ll share one TTS synthesizer for spoken prompts
    private let tts = AVSpeechSynthesizer()

    var body: some View {
        ZStack {
            // Common background color #afc4d6
            Color(red: 175 / 255, green: 196 / 255, blue: 214 / 255)
                .ignoresSafeArea()
            
            switch flowState {
            case .loading:
                LoadingView {
                    // After 3 seconds, transition to welcome
                    withAnimation(.easeOut(duration: 1)) {
                        flowState = .welcome
                    }
                }

            case .welcome:
                WelcomeView {
                    // When user taps, read “Tap to get started.”
                    speak("Tap to get started")
                } onNext: {
                    // Once they tap, we move to permissions
                    flowState = .permissions
                }

            case .permissions:
                PermissionsView(tts: tts, onPermissionsComplete: {
                    flowState = .tutorial
                })

            case .tutorial:
                TutorialView(tts: tts) {
                    withAnimation(.easeOut(duration: 1)) {
                        flowState = .home
                    }
                }
                .onTapGesture {
                    // Stop any ongoing speech
                    tts.stopSpeaking(at: .immediate)
                    // Transition to home screen
                    withAnimation(.easeOut(duration: 1)) {
                        flowState = .home
                    }
                }


            case .home:
                HomeView()
            }
        }
    }

    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        tts.speak(utterance)
    }
}
