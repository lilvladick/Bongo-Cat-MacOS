import SwiftUI

struct ContentView: View {
    @State private var isDraggingEnabled = false
    @State private var clicksCount: Int = UserDefaults.standard.integer(forKey: "clicksCount")
    
    var body: some View {
        VStack {
            Toggle("Drag Mode", isOn: $isDraggingEnabled)
                .onChange(of: isDraggingEnabled) { _, newValue in
                    NotificationCenter.default.post(name: .dragModeChanged, object: newValue)
                }
            Text("Clicks count: \(clicksCount)")
                .onAppear {
                    NotificationCenter.default.addObserver(forName: .clicksUpdated, object: nil, queue: .main) { _ in
                        clicksCount = UserDefaults.standard.integer(forKey: "clicksCount")
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
