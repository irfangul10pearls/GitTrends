//  Created on 1/18/21.

import Foundation

struct Owner: Codable {
    let id: String
    let avatarURL: String
    let login: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarURL = "avatar_url"
    }
}
