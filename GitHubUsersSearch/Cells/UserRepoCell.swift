//
//  UserRepoCell.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 29/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

class UserRepoCell: UITableViewCell {
     @IBOutlet weak var repoNameLabel: UILabel!
     @IBOutlet weak var forksLabel: UILabel!
     @IBOutlet weak var starLabel: UILabel!


    var userRepoCellViewModel : UserRepoCellViewModel?{
        didSet{
            self.bindViewModel()
        }
    }
    
    func bindViewModel(){
        let repoName = userRepoCellViewModel?.repoName ?? "NA"
        let forks = userRepoCellViewModel?.repo_forks ?? "NA"
        let stars = userRepoCellViewModel?.repo_stars ?? "NA"
        self.repoNameLabel.text = repoName
        self.forksLabel.text = forks
        self.starLabel.text = stars
    }
}
