//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositorySearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var repositoryTableView: UITableView!
    
    private var repositories: [GitHubRepository] = []
    private let githubAPI = GitHubAPI()
    private let viewModel = RepositorySearchViewModel()
    
    var selectedRepository: GitHubRepository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSearchBar()
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! RepositoryDetailViewController
            detailVC.repository = selectedRepository!
        }
        
    }
}

extension RepositorySearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchWord = searchBar.text,
              !searchWord.isEmpty else { return }
        
        githubAPI.searchRepositories(keyword: searchWord) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                self.repositoryTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
