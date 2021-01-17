//   Created on 3/10/20.

import UIKit

class BaseController: UIViewController {
    
    var hideNavigationBarWhenPushed: Bool = false
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadView(viewName: self.getViewName())
        (self.view as? BaseView)?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (self.view as? BaseView)?.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        (self.view as? BaseView)?.viewDidAppear()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        (self.view as? BaseView)?.viewWillDisappear()
    }
    
    // MARK: - Private Methods
    private func getViewName() -> String {
        let file = String(describing: type(of: self)).split(separator: ".").last!
        if !file.hasSuffix("Controller") {
            throwException(message: "Invalid class name. Name should end with string 'controller' (e.g. SampleController)")
        }
        
        return file.replacingOccurrences(of: "Controller", with: "View")
    }
    
    private func loadView(viewName: String) {
        if Bundle.main.path(forResource: viewName, ofType: "nib") == nil {
            throwException(message: "\(viewName) nib/class not found in project.")
        }
        let nibs: UINib = UINib(nibName: viewName, bundle: nil)
        
        let array: [AnyObject] = nibs.instantiate(withOwner: nil, options: nil) as [AnyObject]
        if array.isEmpty {
            throwException(message: "\(viewName) nib doesn't have any view (IB error)")
        }
        
        if !(array[0] is BaseView) {
            throwException(message: "\(viewName) nib should be subclass of \(viewName) -> BaseView (IB error).")
        }
        
        let view: BaseView = (array[0] as? BaseView)!
        view.controller = self
        self.view = view
    }
    
    private func throwException(message: String) {
        let exception = NSException(name: NSExceptionName(rawValue: message), reason: nil, userInfo: nil)
        exception.raise()
    }
}
