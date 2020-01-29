//
//  GitUsersCell.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

class GitUsersCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tapEvent: UIButton!
    
    var viewModel: GitUserCellModel? {
        didSet {
            bindViewModel()
        }
    }

    @IBAction func tapEventBtn(_ sender: Any) {
        UIApplication.shared.open(viewModel!.gitHtmUrl)
    }
   
    private func bindViewModel() {
        nameLabel?.text = viewModel?.gitUsreName
        if let gitId = viewModel?.gituser_id{
            tapEvent.setTitle("Repo #: \(gitId)", for: .normal)
        }
        avatarImageView.loadImageUsingCache(viewModel!.gitAvatarUrl)
    }
}
extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
           self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
