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
    
    var repositories:      [[String: Any]] = []
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
        
        let githubAPIURLString = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let githubAPIURL = URL(string: githubAPIURLString) else { return }
        
        URLSession.shared.dataTask(with: githubAPIURL) { (data, res, err) in
            
            guard let data = data,
                  let obj   = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let items = obj["items"] as? [[String: Any]] else { return }
            
            self.repositories = items
            
            DispatchQueue.main.async {
                // これ呼ばなきゃリストが更新されません
                self.tableView.reloadData()
            }
        }
        .resume()
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
        
        content.text = repository["full_name"] as? String ?? ""
        content.secondaryText = repository["language"] as? String ?? ""
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
