//  Created on 1/18/21.

import Foundation

class HttpManager {
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask: URLSessionDataTask?
    
    func get(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        
        dataTask?.cancel()
        
        guard let url = URL(string: urlString) else {
            //call back error
            return
        }
        
        dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(nil, err)
                return
            }
            
            if let data = data,
               let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                DispatchQueue.main.async {
                  completion(data, nil)
                }
            }
        }
        
        dataTask?.resume()
    }
}
