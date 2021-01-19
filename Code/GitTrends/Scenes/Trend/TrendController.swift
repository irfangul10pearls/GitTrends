//  Created on 1/17/21.

import UIKit

class TrendController : BaseController {

    var trendView: TrendView {
        return view as! TrendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Now"
        getTrendsFromService()
    }

    // MARK: - Service
    
    func getTrendsFromService() {
        trendView.showShimmer()
        let _ = TrendService().getGithubTrends { data, error in
            self.trendView.hideShimmer()
            if let err = error {
                self.trendView.showError(err)
            } else {
                self.trendView.setRepo(data!)
            }
        }
    }
}

