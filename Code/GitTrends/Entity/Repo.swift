//  Created on 1/17/21.

import Foundation

struct Repo {
    let name: String
    let remarks: String
    let stars: Int
    let language: String
    let authorDP: String
    let authorUserName: String
    
    static func getRepos() -> [Repo] {
        return [ Repo(name: "popo-python", remarks: "This is a python", stars: 115, language: "Python", authorDP: "irfan", authorUserName: "irfangul92"),
                 Repo(name: "popo-python", remarks: "This is a python", stars: 115, language: "Python", authorDP: "irfan", authorUserName: "irfangul92"),
                 Repo(name: "popo-python", remarks: "This is a python", stars: 115, language: "Python", authorDP: "irfan", authorUserName: "irfangul92"),
                 Repo(name: "popo-python", remarks: "This is a python", stars: 115, language: "Python", authorDP: "irfan", authorUserName: "irfangul92"),
                 Repo(name: "popo-python", remarks: "This is a python", stars: 115, language: "Python", authorDP: "irfan", authorUserName: "irfangul92"),
                 Repo(name: "popo-python", remarks: "This is a python", stars: 115, language: "Python", authorDP: "irfan", authorUserName: "irfangul92")]
    }
}
