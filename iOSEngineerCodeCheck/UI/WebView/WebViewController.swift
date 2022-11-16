import UIKit
import WebKit
import RxSwift
import RxCocoa

final class WebViewController: UIViewController {
    
    static func make(url: URL) -> WebViewController {
        let view = WebViewController.instantiate(storyboardName: "WebView")
        view.url = url
        return view
    }
    
    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet private weak var activityIndecatorView: UIActivityIndicatorView!
    
    private var url: URL!
    
    private let viewModel  = WebViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url))
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = WebViewModel.Input(
            didStartLoad: webView.rx.didStartLoad,
            didFinishLoad: webView.rx.didFinishLoad,
            didFailLoad: webView.rx.didFailProvisionalNavigation
        )
        
        let output = viewModel.transform(input: input)
        
        output.loading
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.activityIndecatorView.startAnimating()
            })
            .disposed(by: disposeBag)
        
        output.loadFinish
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.activityIndecatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}

extension WebViewController: StoryboardInstantiable {}
extension WebViewController: AlertDisplaying {}
