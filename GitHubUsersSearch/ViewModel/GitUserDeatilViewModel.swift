//
//  GitUserDeatilModel.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

class GitUserDetailViewModel{
    
    let gitAPIService : GitAPIService
    init(gitAPIService : GitAPIService = GitAPIService()){
        self.gitAPIService = gitAPIService
    }// let gitUsersCells =  Bindable([GitUserCellType]())
    let gitUserDeatils = Bindable(GitUserDetails())
    let gitUserRepoCellModels = Bindable([UserRepoCellViewModel]())
    func fetchUserDeatils(withUrl : URL){
        gitAPIService.fetchUserDeatils(withUrl: withUrl) { (result) in
                       switch result{
                       case .success(let usersDetails):
                          print(usersDetails)
                          self.gitUserDeatils.value = usersDetails
                       case .failure(let error):
                           print(error)
                       }
        }
    }
    
    func fetchUserRepo(withUrl : URL){
           gitAPIService.fetchUserRepo(repoUrl: withUrl) { (result) in
                          switch result{
                          case .success(let usersDetails):
                             print(usersDetails)
                             self.gitUserRepoCellModels.value = usersDetails
                          case .failure(let error):
                              print(error)
                          }
           }
       }
    
    
}
