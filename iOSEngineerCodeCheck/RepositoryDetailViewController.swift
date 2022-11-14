//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var titleLabel:    UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel:    UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel:    UILabel!
    @IBOutlet private weak var issuesLabel:   UILabel!
    
    var repository: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = repository["full_name"] as? String
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        fetchUserImage()
    }
    
    func fetchUserImage(){
        
        guard let owner = repository["owner"] as? [String: Any],
              let imageURLString = owner["avatar_url"] as? String else { return }
        
        URLSession.shared.dataTask(with: URL(string: imageURLString)!) { (data, res, err) in
            let userImage = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.userImageView.image = userImage
            }
        }
        .resume()
    }
}
