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
    
    // MARK: - Lifecycle Method
    
    override func viewDidLoad() {
        setWebView()
        setActivityIndecatorView()
        bindViewModel()
    }
}

// MARK: - Initialized Method

extension WebViewController {
    
    private func setWebView() {
        webView.load(URLRequest(url: url))
        // スワイプで前画面に戻れる
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setActivityIndecatorView() {
        activityIndecatorView.hidesWhenStopped = true
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
        
        output.loadFail
            .drive(onNext: { [weak self] error in
                guard let self = self else { return }
                // エラーならアラートを表示する
                self.displayNormalAlert(title: error.description(), message: nil)
                self.activityIndecatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}

extension WebViewController: StoryboardInstantiable {}
extension WebViewController: AlertDisplaying {}
