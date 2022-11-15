//
//  RepositorySearchTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 岩本竜斗 on 2022/11/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

class RepositorySearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var userImageView:    UIImageView!
    @IBOutlet private weak var languageIcon:     UIImageView!
    @IBOutlet private weak var titleLabel:       UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stargazersLabel:  UILabel!
    @IBOutlet private weak var languageLabel:    UILabel!
    
    static let identifier = "RepositorySearchTableViewCell"
    
    public func setup(repository: GitHubRepository) {
        userImageView.kf.setImage(with: URL(string: repository.owner.avatarURL),
                                  placeholder: UIImage(systemName: "photo"))
        
        titleLabel.text       = repository.fullName
        stargazersLabel.text  = "\(repository.stargazersCount)"
        descriptionLabel.text = repository.description
        
        if let language = repository.language {
            languageLabel.text = language
            languageIcon.isHidden = false
        } else {
            languageLabel.text = ""
            languageIcon.isHidden = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
