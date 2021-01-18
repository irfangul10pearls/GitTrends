//  Created on 1/17/21.

import UIKit

class TrendController : BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trending Repos"
        getTrendsFromService()
    }

    // MARK: - Service
    
    func getTrendsFromService() {
        let _ = TrendService().getGithubTrends { repos, error in
            NSLog("hello")
        }
    }
}

