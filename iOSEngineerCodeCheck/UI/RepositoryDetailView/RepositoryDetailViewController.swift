//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class RepositoryDetailViewController: UITableViewController {
    
    static func make(repository: GitHubRepository) -> RepositoryDetailViewController {
        let view = RepositoryDetailViewController.instantiate(storyboardName: "RepositoryDetailView")
        view.repository = repository
        return view
    }
    
    @IBOutlet private weak var detailTableView:  UITableView!
    @IBOutlet private weak var userImageView:    UIImageView!
    @IBOutlet private weak var titleLabel:       UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel:    UILabel!
    @IBOutlet private weak var starsLabel:       UILabel!
    @IBOutlet private weak var watchersLabel:    UILabel!
    @IBOutlet private weak var forksLabel:       UILabel!
    @IBOutlet private weak var createdLabel:     UILabel!
    @IBOutlet private weak var updatedLabel:     UILabel!
    @IBOutlet private weak var issuesLabel:      UILabel!
    @IBOutlet private weak var sizeLabel:        UILabel!
    @IBOutlet private weak var homepageLabel:    UILabel!
    
    @IBOutlet private weak var homepageCell:     UITableViewCell!
    @IBOutlet private weak var readmeCell:       UITableViewCell!
    
    private var repository: GitHubRepository!
    
    private let disposeBag = DisposeBag()
    private lazy var viewModel = RepositoryDetailViewModel(repository: repository)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setUserImage()
        bindViewModel()
    }
    
    private func setLabels() {
        titleLabel.text       = repository.fullName
        descriptionLabel.text = repository.description
        
        starsLabel.text    = "\(repository.stargazersCount)"
        watchersLabel.text = "\(repository.watchersCount)"
        forksLabel.text    = "\(repository.forksCount)"
        languageLabel.text = repository.language
        
        createdLabel.text  = DateHelper.shared.formatToString(date: repository.createdAt)
        updatedLabel.text  = DateHelper.shared.formatToString(date: repository.updatedAt)
        issuesLabel.text   = "\(repository.openIssuesCount)"
        sizeLabel.text     = ByteHelper.shared.formatToString(byte: Int64(repository.size))
        
        homepageLabel.text = repository.homepage
        
        // 長さによって大きさを変更する
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
    }
    
    
    private func setUserImage(){
        
        userImageView.kf.setImage(with: URL(string: repository.owner.avatarURL),
                                  placeholder: UIImage(systemName: "photo"))
        userImageView.clipCircle()
    }
    
    private func bindViewModel() {
        let input = RepositoryDetailViewModel.Input(
            viewWillAppear: self.rx.viewWillAppear,
            tableCellTapped: detailTableView.rx.itemSelected.asObservable()
        )
        
        let output = viewModel.transform(input: input)
    }
}

extension RepositoryDetailViewController: StoryboardInstantiable {}
