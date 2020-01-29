//
//  GitUserCellViewModel.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

protocol GitUserCellModel {
    var gitUsreName : String {get}
    var gitUserType : String {get}
    var gitAvatarUrl : String{get}
    var gituser_repos_url : URL{get}
    var gituser_url : URL{get}
    var gituser_followers_url : URL{get}
    var gituser_id: Int{get}
    var gitHtmUrl : URL{get}
}
extension GitHubUser : GitUserCellModel{
    var gitHtmUrl: URL {
        return URL(string: html_url)!
    }
    
    var gituser_id: Int {
        return id
    }
    
    var gitAvatarUrl: String {
        return avatar_url
    }
    
    var gituser_repos_url: URL {
        return URL(string: repos_url)!
    }
    
    var gituser_url: URL {
        return URL(string: url)!
    }
    
    var gituser_followers_url: URL {
        return URL(string: followers_url)!
    }
    
    var gitUsreName: String {
        return login
    }
    var gitUserType: String {
        return type
    }
}
