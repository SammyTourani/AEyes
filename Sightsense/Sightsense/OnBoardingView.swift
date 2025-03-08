import SwiftUI
import AVFoundation

struct TutorialView: View {
    let onTutorialComplete: () -> Void

    @State private var opacity: Double = 0
    @State private var gradientColors: [Color] = [Color.blue.opacity(0.6), Color.cyan.opacity(0.8), Color.purple.opacity(0.6)]
    @State private var gradientAnimationToggle = false

    var body: some View {
        ZStack {
            // Enhanced animated gradient background
            LinearGradient(
                gradient: Gradient(colors: gradientAnimationToggle ? gradientColors : gradientColors.reversed()),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: gradientAnimationToggle)
            .onAppear {
                gradientAnimationToggle.toggle()
            }

            VStack(spacing: 40) {
                // Title text with improved styling
                Text("Tutorial in Progress")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()

                // Instructional text with improved styling
                Text("Tap anywhere to skip")
                    .font(.title.weight(.medium))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .opacity(opacity)
        }
        .contentShape(Rectangle()) // Allows tapping anywhere on screen
        .onTapGesture {
            withAnimation(.easeOut(duration: 0.3)) {
                opacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                onTutorialComplete()
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.3)) {
                opacity = 1
            }
            
            // Optional: Add a timer to automatically advance after a certain time
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) { // Adjust time as needed
                onTutorialComplete()
            }
        }
    }
}
