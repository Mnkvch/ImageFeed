//
//  WebViewViewController.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 13.06.2023.
//

import UIKit
import WebKit

fileprivate let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}

final class WebViewViewController: UIViewController, WKUIDelegate {
    
    weak var delegate: WebViewViewControllerDelegate?
    
    @objc private func didTapBackButton(_ sender: Any?){
        delegate?.webViewViewControllerDidCancel(self)
        
    }
    
        private func code(from navigationAction: WKNavigationAction) -> String? {
            if
                let url = navigationAction.request.url,
                let urlComponents = URLComponents(string: url.absoluteString),
                urlComponents.path == "/oauth/authorize/native",
                let items = urlComponents.queryItems,
                let codeItem = items.first(where: { $0.name == "code" })
            {
                return codeItem.value
            } else {
                return nil
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            let webView = WKWebView()
            webView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(webView)
            webView.backgroundColor = .white
            
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: view.topAnchor),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
    
            let backwardButton = UIButton.systemButton(with: UIImage(named: "BackwardBlack")!, target: self, action: #selector(Self.didTapBackButton))
            backwardButton.tintColor = UIColor(named: "YPBlack")

            
            backwardButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(backwardButton)
            backwardButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
            backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
                    
            //ProgressView
            
            let progressView = UIProgressView(progressViewStyle: .bar)
            progressView.trackTintColor = UIColor(named: "YP Gray")
            progressView.progressTintColor = UIColor(named: "YPBlack")
            progressView.progress = 0.5
            progressView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(progressView)
            progressView.topAnchor.constraint(equalTo: backwardButton.bottomAnchor, constant: 0).isActive = true
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            
            
            var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)!
            urlComponents.queryItems = [
                URLQueryItem(name: "client_id", value: AccessKey),
                URLQueryItem(name: "redirect_uri", value: RedirectURI),             
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: AccessScope)
            ]
            let url = urlComponents.url!
            
            let request = URLRequest(url: url)
            webView.load(request)
            
            //Делаем WebViewViewController навигационным делегатом для webView
            webView.navigationDelegate = self
        }
    }

extension WebViewViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        if let code = code(from: navigationAction) {
            delegate?.webViewViewController(self, didAuthenticateWithCode: code)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
