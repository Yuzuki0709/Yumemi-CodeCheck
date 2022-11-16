import Foundation
@testable import iOSEngineerCodeCheck

struct RepositorySampleData {
    static let appleRepository = GitHubRepository(
        id: 44838949,
        name: "swift",
        fullName: "apple/swift",
        owner: Owner(login: "apple",
                     avatarURL: "https://avatars.githubusercontent.com/u/10639145?v=4"),
        description: "The Swift Programming Language",
        createdAt: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2015, month: 10, day: 23, hour: 21, minute: 15, second: 7))!,
        updatedAt: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2022, month: 10, day: 22, hour: 4, minute: 13, second: 56))!,
        homepage: "https://swift.org",
        size: 888152,
        stargazersCount: 60892,
        watchersCount: 60892,
        language: "C++",
        forksCount: 9787,
        openIssuesCount: 6152)
    
    static let openstackRepoisotry = GitHubRepository(
        id: 790019,
        name: "swift",
        fullName: "openstack/swift",
        owner: Owner(login: "openstack",
                     avatarURL: "https://avatars.githubusercontent.com/u/324574?v=4"),
        description: "OpenStack Storage (Swift). Mirror of code maintained at opendev.org.",
        createdAt: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2010, month: 7, day: 22, hour: 1, minute: 50, second: 7))!,
        updatedAt: Calendar(identifier: .gregorian).date(from: DateComponents(year: 2022, month: 10, day: 18, hour: 5, minute: 45, second: 33))!,
        homepage: "https://opendev.org/openstack/swift",
        size: 65256,
        stargazersCount: 2341,
        watchersCount: 2341,
        language: "Python",
        forksCount: 1059,
        openIssuesCount: 0)
    
    static let expectedData: [GitHubRepository] = [Self.appleRepository, Self.openstackRepoisotry]
}
