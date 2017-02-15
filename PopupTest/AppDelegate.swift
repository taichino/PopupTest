import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    
    let statusItem: NSStatusItem
    let popover: NSPopover
    var popoverMonitor: AnyObject?
    
    override init() {
        popover = NSPopover()
        popover.contentViewController = ContentViewController()
        statusItem = NSStatusBar.system().statusItem(withLength: 24)
        
        super.init()
        setupStatusButton()
    }
    
    func setupStatusButton() {
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(named: "Status")
            statusButton.alternateImage = NSImage(named: "StatusHighlighted")

            //
            // WORKAROUND
            //
            // DummyControl interferes mouseDown events to keep statusButton highlighted while popover is open.
            //
            let dummyControl = DummyControl()
            dummyControl.frame = statusButton.bounds
            statusButton.addSubview(dummyControl)
            statusButton.superview!.subviews = [statusButton, dummyControl]
            dummyControl.action = #selector(AppDelegate.onPress(_:))
            dummyControl.target = self
        }
    }
    
    func onPress(_ sender: AnyObject) {
        if popover.isShown == false {
            openPopover()
        }
        else {
            closePopover()
        }
    }
    
    func openPopover() {
        if let statusButton = statusItem.button {
            statusButton.highlight(true)
            popover.show(relativeTo: NSZeroRect, of: statusButton, preferredEdge: NSRectEdge.minY)
            popoverMonitor = NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown, handler: { (event: NSEvent!) -> Void in
                self.closePopover()
            }) as AnyObject?
        }
    }
    
    func closePopover() {
        popover.close()
        if let statusButton = statusItem.button {
            statusButton.highlight(false)
        }
        if let monitor : AnyObject = popoverMonitor {
            NSEvent.removeMonitor(monitor)
            popoverMonitor = nil
        }
    }
}
