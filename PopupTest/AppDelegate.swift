import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem: NSStatusItem
    let popover: NSPopover
    
    override init() {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(24)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(named: "Status")
            statusButton.alternateImage = NSImage(named: "StatusHighlighted")
            statusButton.action = "onPress:"
        }
        
        popover = NSPopover()
        popover.behavior = .Transient
        popover.contentViewController = ContentViewController()
    }
    
    func onPress(sender: AnyObject) {
        if let statusButton = statusItem.button {
            if popover.shown {
                popover.close()
            }
            else {
                popover.showRelativeToRect(NSZeroRect, ofView: statusButton, preferredEdge: NSMinYEdge)
            }
        }
    }
}