//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 29.06.2023.
//

import UIKit

final class SplashViewController: UIViewController{
    
    let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        if let token = OAuth2TokenStorage().token {
            switchToTabBarController()
        } else {
            performSegue(withIdentifier: ShowAuthenticationScreenSegueIdentifier, sender: nil)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    func switchToTabBarController() {
        // Получаем экземпляр `Window` приложения
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        
        // Cоздаём экземпляр нужного контроллера из Storyboard с помощью ранее заданного идентификатора.
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        
        // Установим в `rootViewController` полученный контроллер
        window.rootViewController = tabBarController
    } 
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        OAuth2Service.shared.fetchOAuthToken(code) { result in
            switch result {
            case .success(let token):
                self.switchToTabBarController()
            case .failure(let error):
                break
            }
        }
    }
}
extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers.first as? AuthViewController
            else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

