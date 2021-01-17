//  Created on 1/17/21.

import UIKit

class DPImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        image = image ?? #imageLiteral(resourceName: "UserPlaceholder")
        makeRounded()
        contentMode = .scaleAspectFit
        backgroundColor = .clear
    }
    
    func setUserImageFromURLString(urlString: String) {
        if let _ = URL(string: urlString) {
            makeRounded()
        } else {
            image = #imageLiteral(resourceName: "UserPlaceholder")
        }
    }
}
