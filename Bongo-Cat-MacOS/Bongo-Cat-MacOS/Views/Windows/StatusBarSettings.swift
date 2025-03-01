import AppKit
import SwiftUI

class StatusBarSettings: NSObject {
    var statusItem: NSStatusItem!
    
    func setup() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem.button {
            if let image = NSImage(named: NSImage.Name("bongo_cat_status")) {
                image.size = NSSize(width: 25, height: 25)
                button.image = image
            }
            button.image?.isTemplate = true
            button.image?.accessibilityDescription = "Bongo Cat Settings"
        }
        
        let menu = NSMenu()
        
        let hostingView = NSHostingView(rootView: ContentView())
        hostingView.frame = NSRect(x: 0, y: 0, width: 100, height: 150)
        
        let menuItem = NSMenuItem()
        menuItem.view = hostingView
        menu.addItem(menuItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
}
