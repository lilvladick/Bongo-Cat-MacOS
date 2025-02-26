import AppKit

class BongoCatWindow: NSWindow {
    override var canBecomeKey: Bool {
        return false
    }
}
