//  Copyright © 2021 10pearls. All rights reserved.

import Foundation

struct Endpoints {
    static let getGithubTrendingReposURL = URL(string: "https://api.github.com/search/repositories?q=language=+sort:stars")!
}
