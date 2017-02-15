import AppKit

class DummyControl : NSControl {
    override func mouseDown(with theEvent: NSEvent) {
        superview!.mouseDown(with: theEvent)
        sendAction(action, to: target)
    }
}
