//  Created on 1/18/21.

import Foundation

struct TrendService {
    let http = HttpManager()
    
    func getGithubTrends(completion: @escaping ([Repo]?, Error?) -> Void) {
        http.get(urlString: "https://api.github.com/search/repositories?q=language=+sort:stars") { data, error in
            
            guard let rspData = data else {
                completion(nil, error)
                return
            }
            
            var decodedObject: Decodable?
            do {
                let decoder = JSONDecoder()
                decodedObject = try decoder.decode( TrendResponse.self, from: rspData)
                onCompletion(.success(decodedObject))
                
            } catch let exception {
                debugPrint("PARSING ERROR: ", (exception as NSError).debugDescription)
                
                onCompletion(.failure(error))
            }
            
            completion([],nil)
        }
    }
}
