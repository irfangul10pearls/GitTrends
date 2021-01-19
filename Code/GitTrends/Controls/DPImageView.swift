//  Created on 1/17/21.

import UIKit

class DPImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeRounded()
        contentMode = .scaleAspectFit
        backgroundColor = .opaqueSeparator
    }
    
    func setUserImageFromURLString(urlString: String) {
        if let url = URL(string: urlString) {
            image = nil
            HttpManager.shared.getImage(url: url) { (image, error) in
                if let img = image {
                    self.image = img
                }
            }
        } else {
            image = nil
        }
    }
}
