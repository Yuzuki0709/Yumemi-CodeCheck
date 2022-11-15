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

    private let viewModel  = RepositorySearchViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSearchBar()
        setTableView()
        bindViewModel()
    }
    
    private func setSearchBar() {
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
    }
    
    private func setTableView() {
        repositoryTableView.register(
            UINib(nibName: "RepositorySearchTableViewCell", bundle: nil),
            forCellReuseIdentifier: RepositorySearchTableViewCell.identifier)
    }
    
    private func bindViewModel() {
        let input = RepositorySearchViewModel.Input(
            searchText: searchBar.rx.text.orEmpty.asObservable(),
            searchButtonTapped: searchBar.rx.searchButtonClicked.asObservable(),
            selectedRepository: repositoryTableView.rx.itemSelected.asObservable()
        )
        
        let output = viewModel.transform(input: input)
        
        output.repositories
            .drive(repositoryTableView.rx.items(
                cellIdentifier: RepositorySearchTableViewCell.identifier,
                cellType: RepositorySearchTableViewCell.self)) { _, element, cell in
                    cell.setup(repository: element)
                }
            .disposed(by: disposeBag)
        
        output.searchDescription
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.selectedRepository
            .drive(onNext: { [weak self] repository in
                guard let self = self else { return }
                
                let vc = RepositoryDetailViewController.make(repository: repository)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
