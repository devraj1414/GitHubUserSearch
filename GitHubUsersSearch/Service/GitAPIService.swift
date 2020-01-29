//
//  GitAPIService.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

class GitAPIService{
    enum FetchFailureReason : Int , Error{
        case unauthorisedError = 401
        case dataNotFound = 404
        case serviceUnavilable = 503
        case timeOut = 504
        
    }
    typealias GitUsersResult = Result<[GitHubUser], Error>
    typealias GitHubUserCompletion = (_ result : GitUsersResult) -> Void
    func fetchGitUsers(withText : String,  completion : @escaping GitHubUserCompletion){
        let searchUserUrl = "https://api.github.com/search/users?q=XX"
        let searchURL = searchUserUrl.replacingOccurrences(of: "XX", with: withText)
        guard let url = URL(string: searchURL) else{
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil || data == nil {
                    completion(.failure(FetchFailureReason(rawValue: (response?.getStatusCode())!)))
                       return
                       
                   }
                   guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                       print("Server error!")
                       return
                   }
                   guard let mime = response.mimeType, mime == "application/json" else {
                       print("Wrong MIME type!")
                       return
                   }
                   do {
                    let gitResult = try JSONDecoder().decode(GitHubResult.self, from: data!)
                        completion(.success(data: gitResult.items))
                   } catch {
                       print("JSON error: \(error.localizedDescription)")
                   }
            }
            task.resume()
        }
    
    
    typealias GitUserDetailResult  = Result<GitUserDetails, FetchFailureReason>
    typealias GitUserDetailsCompletion  = (_ result : GitUserDetailResult)->Void
    func fetchUserDeatils(withUrl : URL, completion : @escaping GitUserDetailsCompletion){
        let task = URLSession.shared.dataTask(with: withUrl) { (data, response, error) in
                       if error != nil || data == nil {
                           completion(.failure(FetchFailureReason(rawValue: (response?.getStatusCode())!)))
                              return
                          }
                          guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                              print("Server error!")
                              return
                          }
                          guard let mime = response.mimeType, mime == "application/json" else {
                              print("Wrong MIME type!")
                              return
                          }
                          do {
                           let userDetails = try JSONDecoder().decode(GitUserDetails.self, from: data!)
                                completion(.success(data: userDetails))
                            
                          } catch {
                              print("JSON error: \(error.localizedDescription)")
                          }
                   }
                   task.resume()
        }
    
    
        typealias GitRepoResult = Result<[UserRepo], FetchFailureReason>
        typealias RepoResultCompletion = (_ result : GitRepoResult)->()
        
    func fetchUserRepo(repoUrl : URL, completion : @escaping RepoResultCompletion){
            let task = URLSession.shared.dataTask(with: repoUrl) { (data, response, error) in
                if error != nil || data == nil {
                    completion(.failure(FetchFailureReason(rawValue: (response?.getStatusCode())!)))
                       return
                   }
                   guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                       print("Server error!")
                       return
                   }
                   guard let mime = response.mimeType, mime == "application/json" else {
                       print("Wrong MIME type!")
                       return
                   }
                   do {
                    let repos = try JSONDecoder().decode([UserRepo].self, from: data!)
                        completion(.success(data: repos))
                   } catch {
                       print("JSON error: \(error.localizedDescription)")
                   }
            }
            task.resume()
        }
    
    
    }

extension URLResponse {

    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
