import AppKit

class ContentViewController : NSViewController {
    
    var searchField : NSSearchField!
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(
            item: view, attribute: .Width, relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 280))
        view.addConstraint(NSLayoutConstraint(
            item: view, attribute: .Height, relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 200))
        
        searchField = NSSearchField()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.focusRingType = .None
        view.addSubview(searchField)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-(20)-[searchField]-(20)-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["searchField":searchField]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(20)-[searchField(==30)]", options: NSLayoutFormatOptions(0), metrics: nil, views: ["searchField":searchField]))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTextChange:", name: NSControlTextDidChangeNotification, object: searchField)
    }
    
    func onTextChange(note : NSNotification) {
        NSLog("Search for %@", searchField.stringValue)
    }
}