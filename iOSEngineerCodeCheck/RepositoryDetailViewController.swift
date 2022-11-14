//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel:    UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel:    UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel:    UILabel!
    @IBOutlet weak var issuesLabel:   UILabel!
    
    var repositorySearchViewController: RepositorySearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = repositorySearchViewController.repositories[repositorySearchViewController.index]
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repository = repositorySearchViewController.repositories[repositorySearchViewController.index]
        
        titleLabel.text = repository["full_name"] as? String
        
        guard let owner = repository["owner"] as? [String: Any],
              let imgURL = owner["avatar_url"] as? String else { return }
        
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
            let img = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.userImageView.image = img
            }
        }
        .resume()
        
    }
    
}
