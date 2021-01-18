//  Created on 1/18/21.

import Foundation

typealias serviceCompletion = (Decodable?, Error?) -> Void

class HttpManager {
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var dataTask: URLSessionDataTask?
    
    private func parseDataToModel<T: Decodable>(_ data: Data, model: T.Type, completion: @escaping serviceCompletion) {
        var decodedObject: Decodable?
        do {
            let decoder = JSONDecoder()
            decodedObject = try decoder.decode(model.self, from: data)
            DispatchQueue.main.async {
                completion(decodedObject, nil)
            }
        } catch let exception {
            NSLog("PARSING ERROR: ", (exception as NSError).debugDescription)
            DispatchQueue.main.async {
                completion(nil, (exception as NSError))
            }
        }
    }
    
    func get<T: Decodable>(urlString: String, model: T.Type, completion: @escaping serviceCompletion) {
        
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
                self.parseDataToModel(data, model: model.self, completion: completion)
            }
        }
        
        dataTask?.resume()
    }
    
    
}
