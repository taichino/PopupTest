import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    
    let statusItem: NSStatusItem
    let popover: NSPopover
    var popoverMonitor: AnyObject?
    
    override init() {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(24)
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(named: "Status")
            statusButton.alternateImage = NSImage(named: "StatusHighlighted")
            statusButton.action = "onPress:"
        }
        
        popover = NSPopover()
        popover.contentViewController = ContentViewController()
        
        super.init()
    }
    
    func onPress(sender: AnyObject) {
        if popover.shown == false {
            openPopover()
        }
        else {
            closePopover()
        }
    }
    
    func openPopover() {
        if let statusButton = statusItem.button {
            popover.showRelativeToRect(NSZeroRect, ofView: statusButton, preferredEdge: NSMinYEdge)
            popoverMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(.LeftMouseDownMask, handler: { (event: NSEvent!) -> Void in
                self.closePopover()
            })
        }
    }
    
    func closePopover() {
        popover.close()
        if let monitor : AnyObject = popoverMonitor {
            NSEvent.removeMonitor(monitor)
            popoverMonitor = nil
        }
    }
}