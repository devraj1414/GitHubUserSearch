//
//  GitUserDetails.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

struct GitUserDetails: Codable{
    var login : String?
    var avatar_url : String?
    var company : String?
    var location : String?
    var email : String?
    var created_at : String?
    var followers : Int?
    var following : Int?
}
