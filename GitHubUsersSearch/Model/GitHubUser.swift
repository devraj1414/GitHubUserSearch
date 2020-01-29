//
//  GitHubUser.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

struct GitHubResult : Codable{
    var items : [GitHubUser]
}
struct GitHubUser : Codable{
     var login : String
     var type : String
     var repos_url : String
     var url : String
     var followers_url : String
    var avatar_url : String
    var id : Int
    var html_url : String
}
