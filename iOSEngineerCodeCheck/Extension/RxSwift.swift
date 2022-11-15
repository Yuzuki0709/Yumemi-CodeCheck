import RxSwift

extension RxSwift.ObservableType where Element: RxSwift.EventConvertible {
    public func elements() -> RxSwift.Observable<Element.Element> {
        return compactMap { $0.event.element }
    }
}
