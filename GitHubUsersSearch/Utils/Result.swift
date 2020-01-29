//
//  Result.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation


enum Result<T, E: Error>{
    case success(data : T)
    case failure(E?)
}
