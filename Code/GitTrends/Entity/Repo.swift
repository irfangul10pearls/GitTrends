//  Created on 1/17/21.

import Foundation

struct Repo: Codable {
    let name: String
    let description: String
    let starsCount: Int
    let language: String?
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case name, description, language, owner
        case starsCount = "stargazers_count"
    }
}
