//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 08.06.2023.
//

import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

final class AuthViewController: UIViewController {
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    weak var delegate: AuthViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewViewController = segue.destination as? WebViewViewController
            else { fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier)") }
            webViewViewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    @objc private func didTabButton(){
        
        performSegue(withIdentifier: "ShowWebView", sender: self)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoImage = UIImage(imageLiteralResourceName:"auth_screen_logo")
        let imageView = UIImageView(image: logoImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let activeButton = UIButton()
        activeButton.addTarget(self, action: #selector(self.didTabButton), for: .touchUpInside)
        
        activeButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        activeButton.layer.cornerRadius = 16
        activeButton.layer.masksToBounds = true
        activeButton.backgroundColor = UIColor (named: "YP White")
        activeButton.setTitle("Войти", for: .normal)
        activeButton.setTitleColor(.init(named: "YPBlack"), for: .normal)
        activeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        activeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activeButton)
        activeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -124).isActive = true
        activeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        activeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        delegate?.authViewController(self, didAuthenticateWithCode: code)
        }
    
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
}

