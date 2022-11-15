import Foundation
import Moya
import RxMoya
import RxSwift

protocol GitHubAPIProtocol {
    
    /// APIからレポジトリを取得する関数
    /// - Parameters:
    ///   - keyword: 検索するキーワード
    ///   - completion: 取得後の処理
    func searchRepositories(keyword: String) -> Observable<[GitHubRepository]>
}

final class GitHubAPI {
    private let provider: MoyaProvider<GitHubAPITarget>
    
    init(provider: MoyaProvider<GitHubAPITarget> = MoyaProvider<GitHubAPITarget>()) {
        self.provider = provider
    }
}

extension GitHubAPI: GitHubAPIProtocol {
    func searchRepositories(keyword: String) -> Observable<[GitHubRepository]> {
        return self.provider.rx.request(.repository(keyword: keyword))
            .map { response in
                if (200..<300).contains(response.statusCode) {
                    return try JSONDecoder().decode(SearchResponse<GitHubRepository>.self,
                                                    from: response.data).items
                }
                
                throw APIClientError(statusCode: response.statusCode)
            }
            .asObservable()
    }
}
