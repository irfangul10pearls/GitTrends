//  Created on 1/18/21.

import Foundation

struct TrendResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    
    let items: [Repo]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
}
