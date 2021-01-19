//  Created on 1/18/21.

import Foundation
import UIKit

typealias serviceCompletion = (Decodable?, Error?) -> Void
typealias imageServiceCompletion = (UIImage?, Error?) -> Void


class HttpManager {
    static let shared = HttpManager()
        
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    var activeDataTasks: [String: URLSessionDataTask] = [:]
    
    private init(){ }

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
    
    private func parseDataToImage(_ data: Data, completion: @escaping imageServiceCompletion) {
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                completion(image, nil)
            }
        } else {
            NSLog("PARSING ERROR: cannot parse image from data")
            DispatchQueue.main.async {
                completion(nil, NSError(domain: "com.gittrends.error.parsing", code: 400, userInfo: ["message": "PARSING ERROR: cannot parse image from data"]))
            }
        }
    }
    
    private func isHTTPStatus200 (_ response: URLResponse?) -> Bool{
        if let response = response as? HTTPURLResponse,
           response.statusCode == 200 {
            return true
        }
        
        return false
    }
    
    func getImage(url: URL, completion: @escaping imageServiceCompletion) {
        cancelAnyOldTaskForURL(url)

        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(nil, err)
                    self.removeTaskForActiveList(url)
                }
                return
            }
            
            if let data = data, self.isHTTPStatus200(response) {
                self.parseDataToImage(data, completion: completion)
            } else {
                completion(nil, NSError(domain: "com.gittrends.http.error", code: 400, userInfo: ["message": "status is other than 200"]))
            }
            
            self.removeTaskForActiveList(url)
        }
        
        dataTask.resume()
        addTaskToActiveList(url, task: dataTask)
    }
    
    func get<T: Decodable>(url: URL, model: T.Type, completion: @escaping serviceCompletion) {
        cancelAnyOldTaskForURL(url)
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(nil, err)
                    self.removeTaskForActiveList(url)
                }
                return
            }
            
            if let data = data, self.isHTTPStatus200(response) {
                self.parseDataToModel(data, model: model.self, completion: completion)
            } else {
                completion(nil, NSError(domain: "com.gittrends.http.error", code: 400, userInfo: ["message": "status is other than 200"]))
            }
            
            self.removeTaskForActiveList(url)
        }
        
        dataTask.resume()
        addTaskToActiveList(url, task: dataTask)
    }
    
    private func cancelAnyOldTaskForURL(_ url: URL) {
        if let task = activeDataTasks[url.absoluteString] {
            task.cancel()
        }
    }
    
    private func removeTaskForActiveList(_ url: URL) {
        activeDataTasks.removeValue(forKey: url.absoluteString)
    }
    
    private func addTaskToActiveList(_ url: URL, task: URLSessionDataTask) {
        activeDataTasks[url.absoluteString] = task
    }
}
