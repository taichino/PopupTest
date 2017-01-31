import AppKit

class ContentViewController : NSViewController {
    
    var searchField : NSSearchField!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(
            item: view, attribute: .width, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 280))
        view.addConstraint(NSLayoutConstraint(
            item: view, attribute: .height, relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 200))
        
        searchField = NSSearchField()
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.focusRingType = .none
        view.addSubview(searchField)
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(20)-[searchField]-(20)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["searchField":searchField]))
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(20)-[searchField(==30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["searchField":searchField]))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ContentViewController.onTextChange(_:)), name: NSNotification.Name.NSControlTextDidChange, object: searchField)
    }
    
    func onTextChange(_ note : Notification) {
        NSLog("Search for %@", searchField.stringValue)
    }
}
