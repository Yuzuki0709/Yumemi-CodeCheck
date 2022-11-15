//
//  RepositorySearchTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 岩本竜斗 on 2022/11/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositorySearchTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var userImageView:    UIImageView!
    @IBOutlet private weak var languageIcon:     UIImageView!
    @IBOutlet private weak var titleLabel:       UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var stargazersLabel:  UILabel!
    @IBOutlet private weak var languageLabel:    UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
