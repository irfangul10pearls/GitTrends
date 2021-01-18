//  Created on 1/17/21.

import UIKit

class TrendingRepoCell: UITableViewCell {

    @IBOutlet weak var imgViewAuthorDP: DPImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblRepoName: UILabel!
    @IBOutlet weak var lblRepoRemarks: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblStars: UILabel!
    @IBOutlet weak var stackViewDetails: UIStackView!
    
    func setCell(repo: Repo) {
//        imgViewAuthorDP.image = UIImage(named: repo.owner.avatarURL)
        lblAuthorName.text = repo.owner.login
        lblRepoName.text = repo.name
        lblRepoRemarks.text = repo.description
        lblLanguage.text = repo.language
        lblStars.text = String(repo.starsCount)
        
        selectedBackgroundView = UIView(frame: self.bounds)
        selectedBackgroundView?.backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        lblRepoRemarks.isHidden = !selected
        stackViewDetails.isHidden = !selected
    }
}
