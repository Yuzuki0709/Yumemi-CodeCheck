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
    
    /// レポジトリ名を検索して、レポジトリの配列が返ってくることを確認するテスト
    func testSearchRepository() {
        let repositories = scheduler.createObserver([GitHubRepository].self)
        
        viewModel = RepositorySearchViewModel(githubAPI: GitHubAPIMock())
        output    = viewModel.transform(input: input)
        
        output.repositories
            .drive(repositories)
            .disposed(by: disposeBag)
        
        inputText(time: 5, "Swift")
        searchButtonTap(time: 10)
        
        scheduler.start()
        
        XCTAssertEqual(repositories.events, [
            .next(10, RepositorySampleData.expectedData)
        ])
    }
    
    /// エラーが返ってくることを確認するテスト
    func testSearchResultError() {
        enum TestError: Error {
            case dummyError1
            case dummyError2
        }
        
        var error: Error!
        let expectation = expectation(description: "非同期処理")
        
        viewModel = RepositorySearchViewModel(githubAPI: GitHubAPIMock(error: TestError.dummyError1))
        output    = viewModel.transform(input: input)
        
        // error = try! output.error.toBlocking().first!
        // 上の方法ではうまくいかなかったので、expectationを使って非同期テストをしている
        output.error
            .drive(onNext: {
                error = $0
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        inputText(time: 5, "")
        searchButtonTap(time: 10)
        
        scheduler.start()
        self.wait(for: [expectation], timeout: 10.0)
        
        XCTAssertEqual(error as! TestError, TestError.dummyError1)
        XCTAssertNotEqual(error as! TestError, TestError.dummyError2)
    }
    
    /// レポジトリをタップした時、該当のレポジトリが返ってくることを確認するテスト
    func testSelectedRepository() {
        let selectedRepository = scheduler.createObserver(GitHubRepository.self)
        
        viewModel = RepositorySearchViewModel(githubAPI: GitHubAPIMock())
        output    = viewModel.transform(input: input)
        
        output.selectedRepository
            .drive(selectedRepository)
            .disposed(by: disposeBag)
        
        inputText(time: 5, "Swift")
        searchButtonTap(time: 10)
        selectRepository(time: 15, IndexPath(row: 0, section: 0))
        
        scheduler.start()
        
        XCTAssertEqual(selectedRepository.events, [
            .next(15, RepositorySampleData.appleRepository)
        ])
    }
    
    /// 検索ワードに応じて、searchDescriptionが変化することを確認するテスト
    func testSearchDescription() {
        viewModel = RepositorySearchViewModel(githubAPI: GitHubAPIMock())
        
        XCTContext.runActivity(named: "25文字以下") { _ in
            let searchDescription = scheduler.createObserver(String.self)
            let searchWord        = String(repeating: "a", count: 24)
            
            output = viewModel.transform(input: input)
            
            output.searchDescription
                .drive(searchDescription)
                .disposed(by: disposeBag)
            
            inputText(time: 5, searchWord)
            searchButtonTap(time: 10)
            
            scheduler.start()
            
            XCTAssertEqual(searchDescription.events, [
                .next(10, "\(searchWord)の検索結果")
            ])
        }
        
        // スケジューラをリセット
        scheduler = TestScheduler(initialClock: 0)
        
        XCTContext.runActivity(named: "25文字以上") { _ in
            let searchDescription = scheduler.createObserver(String.self)
            let searchWord        = String(repeating: "a", count: 25)
            
            output = viewModel.transform(input: input)
            
            output.searchDescription
                .drive(searchDescription)
                .disposed(by: disposeBag)
            
            inputText(time: 5, searchWord)
            searchButtonTap(time: 10)
            
            scheduler.start()
            
            XCTAssertEqual(searchDescription.events, [
                .next(10, "\(searchWord)...の検索結果")
            ])
        }
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
    
    private func selectRepository(time: TestTime, _ indexPath: IndexPath) {
        scheduler
            .createHotObservable([.next(time, indexPath)])
            .bind(to: selectedRepository)
            .disposed(by: disposeBag)
    }
}
