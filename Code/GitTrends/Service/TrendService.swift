//  Created on 1/18/21.

import Foundation

struct TrendService {
    let http = HttpManager()
    
    func getGithubTrends(completion: @escaping ([Repo]?, Error?) -> Void) {
        http.get(urlString: Endpoints.getGithubTrendingRepos,
                 model: TrendResponse.self) { data, error in
            
            guard let trends = data as? TrendResponse else {
                completion(nil, error)
                return
            }
            
            completion(trends.items,nil)
        }
    }
}
