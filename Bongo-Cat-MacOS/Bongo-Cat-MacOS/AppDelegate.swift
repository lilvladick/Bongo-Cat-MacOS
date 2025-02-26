import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: BongoCatWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let screenFrame = NSScreen.main?.frame ?? .zero
        let catSize = CGSize(width: 150, height: 100)
        let catOrigin = NSPoint(x: (screenFrame.width-catSize.width), y: 0)
        
        window = BongoCatWindow(
            contentRect: NSRect(origin: catOrigin, size: catSize),
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )
        
        window.isOpaque = false
        window.backgroundColor = .clear
        window.level = .screenSaver
        window.ignoresMouseEvents = true
        
        let contentView = NSHostingView(rootView: BongoCatView())
        contentView.frame = NSRect(origin: .zero, size: catSize)
        
        window.contentView = contentView
        window.makeKeyAndOrderFront(nil)
        
        NSEvent.addGlobalMonitorForEvents(matching: [.keyDown, .leftMouseDown]) { _ in
            NotificationCenter.default.post(name: .bongoHit, object: nil)
        }
    }
}

extension Notification.Name {
    static let bongoHit = Notification.Name("bongoHit")
}

