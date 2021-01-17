//  Created on 1/17/21.

import UIKit

extension UITableViewCell {
    
    static var NibName: String {
        return String(describing: self)
    }
       
    static var Nib: UINib {
        return UINib(nibName: NibName, bundle: nil)
    }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
