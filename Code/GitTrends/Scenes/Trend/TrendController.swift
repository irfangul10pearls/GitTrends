//  Created on 1/17/21.

import UIKit

class TrendController : BaseController {

    var trendView: TrendView {
        return view as! TrendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Repos"
        getTrendsFromService()
    }

    // MARK: - Service
    
    func getTrendsFromService() {
        trendView.showShimmer()
        let _ = TrendService().getGithubTrends { data, error in
            self.trendView.hideShimmer()
            if let e = error {
                self.trendView.showError(e)
            } else {
                self.trendView.setRepo(data!)
            }
        }
    }
}

