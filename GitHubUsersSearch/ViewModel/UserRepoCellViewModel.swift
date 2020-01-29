//
//  UserRepoCellViewModel.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 29/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

protocol UserRepoCellViewModel {
    var repoName : String{get}
    var repo_forks : String{get}
    var repo_stars: String{get}
}

extension UserRepo : UserRepoCellViewModel{
    var repoName: String {
        return name
    }
    var repo_forks: String {
        return "\(forks) forks"
    }
    var repo_stars: String {
        return "\(stargazers_count) Stars"
    }
}


