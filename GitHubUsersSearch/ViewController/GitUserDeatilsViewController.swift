//
//  GitUserDeatilsViewController.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

class GitUserDeatilsViewController: UIViewController {

    var gitUsersModel : GitUserCellModel?
    let gitUsersDetailViewModel : GitUserDetailViewModel = GitUserDetailViewModel()
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var joiningDateLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followinglabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var gitUserCellModels = [UserRepoCellViewModel](){
        didSet{
            DispatchQueue.main.async {
                              self.tableView?.reloadData()
                       }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        // Do any additional setup after loading the view.
        gitUsersDetailViewModel.fetchUserDeatils(withUrl: gitUsersModel!.gituser_url)
        gitUsersDetailViewModel.fetchUserRepo(withUrl: gitUsersModel!.gituser_repos_url)
        
        gitUsersDetailViewModel.gitUserRepoCellModels.bindAndExecute() { [weak self] _ in
            self!.gitUserCellModels = (self?.gitUsersDetailViewModel.gitUserRepoCellModels.value)!
        }
    }
    
    func bindViewModel() {
        gitUsersDetailViewModel.gitUserDeatils.bindAndExecute(){[weak self] _ in
            let userDetail = self?.gitUsersDetailViewModel.gitUserDeatils.value
            let name = userDetail?.login ?? "NA"
            let location = userDetail?.location ?? "NA"
            let email = userDetail?.email ?? "NA"
            let joinDate = userDetail?.created_at ?? "NA"
            let followers = userDetail?.followers ?? 0
            let following = userDetail?.following ?? 0
            
            DispatchQueue.main.async {
                self?.userNameLabel.text = name
                self?.userEmailLabel.text = email
                self?.locationLabel.text = location
                self?.joiningDateLabel.text = joinDate
                self?.followersLabel.text = String(followers) + " Followers"
                self?.followinglabel.text = "Following " + String(following)
                if let avatarURL = userDetail?.avatar_url{
                    self?.avatarImage.loadImageUsingCache(avatarURL)
                }
            }
        }
    }
}
extension UIImageView {
    func loadImageUsingCache (_ urlString : String) {
        let imageCache = NSCache<AnyObject, AnyObject>()
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) {
            self.image = cachedImage as? UIImage
            return
        }
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if data != nil {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as AnyObject)
                    DispatchQueue.main.async(execute: {
                        self.image = image
                    })
                }
            }
        }.resume()
    }
}


extension GitUserDeatilsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.gitUserCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.gitUserCellModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell") as? UserRepoCell else {
                                             return UITableViewCell()
                                         }
        cell.userRepoCellViewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

extension GitUserDeatilsViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0{
              self.gitUserCellModels = self.gitUsersDetailViewModel.gitUserRepoCellModels.value
        }
        
        let resultModel = self.gitUsersDetailViewModel.gitUserRepoCellModels.value.filter({
            (repoName) -> Bool in
            repoName.repoName.range(of: searchText, options: .caseInsensitive) != nil
        })
        self.gitUserCellModels = resultModel
      }
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
             searchBar.resignFirstResponder()
         self.gitUserCellModels = self.gitUsersDetailViewModel.gitUserRepoCellModels.value
      }
      
}
