//
//  UserRepo.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 29/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

struct UserRepo : Codable{
    var name : String
    var forks : Int
    var stargazers_count : Int
}
