import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: BongoCatWindow!
    var settingsWindow: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let screenFrame = NSScreen.main?.frame ?? .zero
        let catSize = CGSize(width: 150, height: 100)
        let catOriginDefault = NSPoint(x: (screenFrame.width - catSize.width), y: 0)
        
        let xCoordinates = UserDefaults.standard.double(forKey: "xCoordinates")
        let yCoordinates = UserDefaults.standard.double(forKey: "yCoordinates")
        
        let catOrigin = (xCoordinates != 0 || yCoordinates != 0)
            ? NSPoint(x: xCoordinates, y: yCoordinates) : catOriginDefault
        
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
        
        settingsWindow = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: 300, height: 200),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        settingsWindow.title = "Settings"
        settingsWindow.contentView = NSHostingView(rootView: ContentView())
        settingsWindow.makeKeyAndOrderFront(nil)
    }
}
