//
//  RepositorySearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RepositorySearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var repositoryTableView: UITableView!
    
    private var repositories: [GitHubRepository] = []
    private let githubAPI  = GitHubAPI()
    private let viewModel  = RepositorySearchViewModel()
    private let disposeBag = DisposeBag()
    
    var selectedRepository: GitHubRepository? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSearchBar()
        bindViewModel()
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
    }
    
    private func bindViewModel() {
        let input = RepositorySearchViewModel.Input(
            searchText: searchBar.rx.text.orEmpty.asObservable(),
            searchButtonTapped: searchBar.rx.searchButtonClicked.asObservable(),
            selectedRepository: repositoryTableView.rx.itemSelected.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.repositories
            .drive(repositoryTableView.rx.items) { _, row, element in
                let cell    = UITableViewCell()
                var content = cell.defaultContentConfiguration()
                
                content.text = element.fullName
                content.secondaryText = element.language ?? ""
                cell.contentConfiguration = content
                cell.tag = row
                
                return cell
            }
            .disposed(by: disposeBag)
        
        output.searchDescription
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! RepositoryDetailViewController
            detailVC.repository = selectedRepository!
        }
        
    }
}
