import SwiftUI

struct BongoCatView: View {
    @State private var currentImage = "bongo_cat_default"
    @State private var isBusyCat = false
    
    var body: some View {
        Image(currentImage)
            .resizable()
            .scaledToFit()
            .onReceive(NotificationCenter.default.publisher(for: .bongoHit)) { _ in
                if !isBusyCat {
                    animateBongoCat()
                }
            }
    }
    
    private func animateBongoCat() {
        isBusyCat = true
        currentImage = Bool.random() ? "bongo_cat_left" : "bongo_cat_right"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            currentImage = "bongo_cat_default"
            isBusyCat = false
        }
    }
}
