//
//  GitHubSearchTableViewController.swift
//  GitHubUsersSearch
//
//  Created by Suruchi Kumari on 28/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

class GitHubSearchTableViewController: UITableViewController {

    let gitUsersModel : GitUsersViewModel = GitUsersViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        gitUsersModel.gitUsersCells.bindAndExecute() { [weak self] _ in
            DispatchQueue.main.async {
                   self?.tableView?.reloadData()
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "gitUserDetails",
                  let gitUserDeatilsViewController = segue.destination as? GitUserDeatilsViewController {
            if let indexPath = tableView.indexPathForSelectedRow{
                switch gitUsersModel.gitUsersCells.value[indexPath.row] {
                case .normal(let viewModel):
                    gitUserDeatilsViewController.gitUsersModel = viewModel
                default:
                    break
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gitUsersModel.gitUsersCells.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch gitUsersModel.gitUsersCells.value[indexPath.row] {
        case .normal(let cellViewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? GitUsersCell else {
                                      return UITableViewCell()
                                  }
                                  cell.viewModel = cellViewModel
                                  return cell
        case .error(let message):
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = message
            return cell
        case .empty:
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = false
            cell.textLabel?.text = "No data available"
            return cell
        
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

}

extension GitHubSearchTableViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.gitUsersModel.fetchGitUsersWith(startsWith: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
    }
    
}
