//
//  GitUsersModel.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation
//https://api.github.com/users/applenob
class GitUsersViewModel{
    
    enum GitUserCellType {
         case normal(cellViewModel: GitUserCellModel)
         case error(message: String)
         case empty
     }
    let gitAPIService : GitAPIService
    init(gitAPIService : GitAPIService = GitAPIService()){
        self.gitAPIService = gitAPIService
    }
    
    let gitUsersCells =  Bindable([GitUserCellType]())
    func fetchGitUsersWith(startsWith : String){
        self.gitAPIService.fetchGitUsers(withText: startsWith) { (result) in
            switch result{
            case .success(data: let users):
                guard users.count > 0 else {
                    self.gitUsersCells.value = [.empty]
                                   return
                               }
                self.gitUsersCells.value = users.compactMap({ (gitUser)in
                    .normal(cellViewModel: gitUser)
                })
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

