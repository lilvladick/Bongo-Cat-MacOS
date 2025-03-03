import AppKit

class BongoCatWindow: NSWindow {
    private var isDragModeOn = false {
        didSet {
            ignoresMouseEvents = !isDragModeOn
        }
    }
    
    override var canBecomeKey: Bool {
        return false
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        setupNotifications()
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(dragModeChanged(_:)), name: .dragModeChanged, object: nil)
    }
    
    @objc private func dragModeChanged(_ notification: Notification) {
        if let newValue = notification.object as? Bool {
            isDragModeOn = newValue
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if isDragModeOn {
            let windowFrame = frame
            let mouseLocation = event.locationInWindow
            let offset = NSPoint(x: mouseLocation.x, y: windowFrame.height - mouseLocation.y)
            dragWindow(with: event, offset: offset)
        }
    }
    
    private func dragWindow(with event: NSEvent, offset: NSPoint) {
        var newOrigin = frame.origin
        while let dragEvent = self.nextEvent(matching: [.leftMouseDragged, .leftMouseUp]) {
            if dragEvent.type == .leftMouseUp {
                UserDefaults.standard.set(newOrigin.x, forKey: "xCoordinates")
                UserDefaults.standard.set(newOrigin.y, forKey: "yCoordinates")
                break
            }
            let mouseLocation = dragEvent.locationInWindow
            newOrigin.x = mouseLocation.x - offset.x
            newOrigin.y = mouseLocation.y - offset.y
            setFrameOrigin(newOrigin)
        }
    }
}
