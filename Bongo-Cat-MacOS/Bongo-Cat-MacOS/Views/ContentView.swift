import SwiftUI

struct ContentView: View {
    @State private var isDraggingEnabled = false
    
    var body: some View {
        VStack {
            Toggle("Drag Mode", isOn: $isDraggingEnabled)
                .onChange(of: isDraggingEnabled) { _, newValue in
                    NotificationCenter.default.post(name: .dragModeChanged, object: newValue)
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
