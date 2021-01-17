//  Created on 1/17/21.

import UIKit

extension UIView {
    func makeRounded() {
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}
