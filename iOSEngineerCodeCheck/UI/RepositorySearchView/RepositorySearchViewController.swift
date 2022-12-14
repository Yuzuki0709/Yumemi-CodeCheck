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
import PKHUD
import Lottie

/// 検索結果に応じてアニメーションを変化させるためのEnum
fileprivate enum SearchResultAnimation: String {
    case empty = "Empty"
    case error = "Error"
}

final class RepositorySearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var repositoryTableView: UITableView!

    private let viewModel  = RepositorySearchViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = setAnimationView()
        // テスト用のIdentifierを設定
        animationView.accessibilityIdentifier = "search_searchresult_animationview"
        
        return animationView
    }()
    
    // MARK: - Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSearchBar()
        setTableView()
        bindViewModel()
    }
}

// MARK: - Initialized Method

extension RepositorySearchViewController {
    private func setSearchBar() {
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        
        // 検索ボタンが押されたときに、キーボードを閉じる
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        repositoryTableView.register(
            UINib(nibName: "RepositorySearchTableViewCell", bundle: nil),
            forCellReuseIdentifier: RepositorySearchTableViewCell.identifier)
        
        // セルがタップされた後に、選択状態を解除する
        repositoryTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.repositoryTableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setAnimationView() -> LottieAnimationView {
        let animationView = LottieAnimationView()
        
        animationView.frame = CGRect(x: 0,
                                     y: repositoryTableView.bounds.minY,
                                     width: view.bounds.width,
                                     height: repositoryTableView.bounds.height)
        
        animationView.center         = repositoryTableView.center
        animationView.loopMode       = .loop
        animationView.contentMode    = .scaleAspectFit
        animationView.animationSpeed = 1
        
        view.addSubview(animationView)
        
        return animationView
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
        
        output.repositories
            .drive(onNext: { [weak self] repositories in
                guard let self = self else { return }
                // 検索結果が空だったら、アニメーションとアラートを表示する
                if repositories.isEmpty {
                    self.playAnimation(.empty)
                    self.displayNormalAlert(title: "検索結果が見つかりませんでした。",
                                            message: "別のキーワードをお試しください。")
                } else {
                    self.animationView.isHidden       = true
                    self.repositoryTableView.isHidden = false
                }
            })
            .disposed(by: disposeBag)
        
        output.searchDescription
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.selectedRepository
            .drive(onNext: { [weak self] repository in
                guard let self = self else { return }
                // レポジトリセルをタップしたら、詳細画面に遷移する
                let vc = RepositoryDetailViewController.make(repository: repository)
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                // エラーだったら、アニメーションとアラートを表示する
                self.playAnimation(.error)
                self.displayNormalAlert(title: error.localizedDescription, message: nil)
            })
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive(onNext: { isLoading in
                // ロード中はアニメーションを表示
                isLoading ? HUD.show(.progress) : HUD.hide()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private Method

extension RepositorySearchViewController {
    private func playAnimation(_ result: SearchResultAnimation) {
        animationView.animation = LottieAnimation.named(result.rawValue)
        animationView.isHidden  = false
        animationView.play()
    }
}

extension RepositorySearchViewController: AlertDisplaying {}
