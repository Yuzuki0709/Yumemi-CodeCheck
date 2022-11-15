//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

final class RepositoryDetailViewController: UITableViewController {
    
    static func make(repository: GitHubRepository) -> RepositoryDetailViewController {
        let view = RepositoryDetailViewController.instantiate(storyboardName: "RepositoryDetailView")
        view.repository = repository
        return view
    }
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var titleLabel:    UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel:    UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel:    UILabel!
    @IBOutlet private weak var issuesLabel:   UILabel!
    
    private var repository: GitHubRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setUserImage()
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
    
    
    private func setUserImage(){
        
        userImageView.kf.setImage(with: URL(string: repository.owner.avatarURL),
                                  placeholder: UIImage(systemName: "photo"))
    }
}

extension RepositoryDetailViewController: StoryboardInstantiable {}
