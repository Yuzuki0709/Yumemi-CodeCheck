import Foundation
import Moya

protocol GitHubAPIProtocol {
    
    /// APIからレポジトリを取得する関数
    /// - Parameters:
    ///   - keyword: 検索するキーワード
    ///   - completion: 取得後の処理
    func searchRepositories(keyword: String,
                            completion: @escaping ((Result<[GitHubRepository], Error>) -> Void))
}

final class GitHubAPI {
    private let provider: MoyaProvider<GitHubAPITarget>
    
    init(provider: MoyaProvider<GitHubAPITarget> = MoyaProvider<GitHubAPITarget>()) {
        self.provider = provider
    }
}

extension GitHubAPI: GitHubAPIProtocol {
    func searchRepositories(keyword: String, completion: @escaping ((Result<[GitHubRepository], Error>) -> Void)) {
        self.provider.request(.repository(keyword: keyword)) { result in
            switch result {
            case .success(let response):
                do {
                    let searchResult = try JSONDecoder().decode(SearchResponse<GitHubRepository>.self, from: response.data)
                    completion(.success(searchResult.items))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
