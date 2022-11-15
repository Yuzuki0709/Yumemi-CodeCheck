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
    
    var repository: GitHubRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        fetchUserImage()
    }
    
    private func setLabels() {
        titleLabel.text    = repository.fullName
        languageLabel.text = "Written in \(repository.language ?? "")"
        starsLabel.text    = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text    = "\(repository.forksCount) forks"
        issuesLabel.text   = "\(repository.openIssuesCount) open issues"
        
        // 長さによって大きさを変更する
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }
    
    private func fetchUserImage(){
        
        guard let avatarImageURL = URL(string: repository.owner.avatarURL) else { return }
        
        URLSession.shared.dataTask(with: avatarImageURL) { (data, res, err) in
            guard let data = data,
                  let avatarImage = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.userImageView.image = avatarImage
            }
        }
        .resume()
    }
}
