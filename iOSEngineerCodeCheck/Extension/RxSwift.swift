import RxSwift

extension RxSwift.ObservableType where Element: RxSwift.EventConvertible {
    public func elements() -> RxSwift.Observable<Element.Element> {
        return compactMap { $0.event.element }
    }
    
    public func errors() -> RxSwift.Observable<Swift.Error> {
        return compactMap { $0.event.error }
    }
}
