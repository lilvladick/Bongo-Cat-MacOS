import SwiftUI

struct BongoCatView: View {
    @State private var currentImage = "bongo_cat_default"
    
    var body: some View {
        Image(currentImage)
            .resizable()
            .scaledToFit()
            .onReceive(NotificationCenter.default.publisher(for: .bongoHit)) { _ in
                animateBongoCat()
            }
    }
    
    private func animateBongoCat() {
        currentImage = Bool.random() ? "bongo_cat_left" : "bongo_cat_right"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            currentImage = "bongo_cat_default"
        }
    }
}
