import XCTest
import RxSwift
import RxCocoa
import RxTest

@testable import iOSEngineerCodeCheck

final class RepositorySearchViewModelTest: XCTestCase {
    var scheduler:          TestScheduler!
    var disposeBag:         DisposeBag!
    var searchText:         PublishRelay<String>!
    var searchButtonTapped: PublishRelay<Void>!
    var selectedRepository: PublishRelay<IndexPath>!
    var viewModel:          RepositorySearchViewModel!
    var input:              RepositorySearchViewModel.Input!
    var output:             RepositorySearchViewModel.Output!
    
    override func setUp() {
        scheduler  = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        searchText         = PublishRelay<String>()
        searchButtonTapped = PublishRelay<Void>()
        selectedRepository = PublishRelay<IndexPath>()
        
        input = RepositorySearchViewModel.Input(
            searchText: searchText.asObservable(),
            searchButtonTapped: searchButtonTapped.asObservable(),
            selectedRepository: selectedRepository.asObservable()
        )
    }
    
    private func inputText(time: TestTime, _ word: String) {
        scheduler
            .createHotObservable([.next(time, word)])
            .bind(to: searchText)
            .disposed(by: disposeBag)
    }
    
    private func searchButtonTap(time: TestTime) {
        scheduler
            .createHotObservable([.next(time, Void())])
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
    }
}
