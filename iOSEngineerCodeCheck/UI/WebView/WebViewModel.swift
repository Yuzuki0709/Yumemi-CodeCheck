import UIKit
import WebKit
import RxSwift
import RxCocoa

final class WebViewModel {
    private let disposeBag = DisposeBag()
}

extension WebViewModel: ViewModelType {
    struct Input {
        let didStartLoad:  Observable<WKNavigation>
        let didFinishLoad: Observable<WKNavigation>
        let didFailLoad:   Observable<(WKNavigation, Error)>
    }
    
    struct Output {
        let loading:    Driver<Void>
        let loadFinish: Driver<Void>
        let loadFail:   Driver<WebLoadError>
    }
    
    func transform(input: Input) -> Output {
        let loading    = PublishRelay<Void>()
        let loadFinish = PublishRelay<Void>()
        let loadFail   = PublishRelay<WebLoadError>()
        
        return Output(
            loading: loading.asDriver(onErrorDriveWith: .empty()),
            loadFinish: loadFinish.asDriver(onErrorDriveWith: .empty()),
            loadFail: loadFail.asDriver(onErrorDriveWith: .empty())
        )
    }
}
