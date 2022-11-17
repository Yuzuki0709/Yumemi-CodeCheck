import RxSwift

extension RxSwift.ObservableType where Element: RxSwift.EventConvertible {
    /// EventのElement要素を取得する
    public func elements() -> RxSwift.Observable<Element.Element> {
        return compactMap { $0.event.element }
    }
    
    /// EventのError要素を取得する
    public func errors() -> RxSwift.Observable<Swift.Error> {
        return compactMap { $0.event.error }
    }
}
