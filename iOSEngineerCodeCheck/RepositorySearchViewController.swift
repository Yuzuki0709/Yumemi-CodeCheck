//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositorySearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var repositories:   [GitHubRepository] = []
    var selectedRepository: [String: Any]? = nil
    
    private let githubAPI = GitHubAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchWord = searchBar.text,
              !searchWord.isEmpty else { return }
        
        githubAPI.searchRepositories(keyword: searchWord) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! RepositoryDetailViewController
            detailVC.repository = selectedRepository!
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell       = UITableViewCell()
        let repository = repositories[indexPath.row]
        var content    = cell.defaultContentConfiguration()
        
        content.text = repository.fullName
        content.secondaryText = repository.language
        cell.contentConfiguration = content
        cell.tag = indexPath.row
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedRepository = repositories[indexPath.row]
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
}
