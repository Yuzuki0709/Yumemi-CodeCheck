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
    
    
    /// レポジトリのREADMEを検索する関数
    /// - Parameters:
    ///   - ownerName: レポジトリの所有者
    ///   - repositoryName: レポジトリ名
    /// - Returns: 正常に終わればObservable<GitHubReadme>を、エラーならErrorを返す
    func searchReadme(ownerName: String, repositoryName: String) -> Observable<GitHubReadme>
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
                    let decoder = JSONDecoder()
                    // Dateのフォーマット型を指定
                    // createdAt, updatedAtをDate型としてデコードできるようにするため
                    decoder.dateDecodingStrategy = .iso8601
                    
                    return try decoder.decode(SearchResponse<GitHubRepository>.self,
                                                    from: response.data).items
                }
                
                throw APIClientError(statusCode: response.statusCode)
            }
            .asObservable()
    }
    
    func searchReadme(ownerName: String, repositoryName: String) -> Observable<GitHubReadme> {
        return self.provider.rx.request(.readme(ownerName: ownerName, repositoryName: repositoryName))
            .map { response in
                if (200..<300).contains(response.statusCode) {
                    return try JSONDecoder().decode(GitHubReadme.self, from: response.data)
                }
                
                throw APIClientError(statusCode: response.statusCode)
            }
            .asObservable()
    }
}
