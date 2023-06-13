//
//  AuthViewController.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 08.06.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    
    @objc private func didTabButton(){
        
        performSegue(withIdentifier: "SegueWebViewView", sender: self)
        
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
        
   //     let activeButton = UIButton()
        let activeButton = UIButton.systemButton(with: UIImage(systemName: "ipad.and.arrow.forward")!, target: self, action: #selector(Self.didTabButton))
        
        
        activeButton.layer.cornerRadius = 16
        activeButton.backgroundColor = .white
        activeButton.setTitle("Войти", for: .normal)
        activeButton.setTitleColor(.black, for: .normal)
        activeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        activeButton.isEnabled = true
        activeButton.isHidden = false

     
        activeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activeButton)
       activeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -124).isActive = true
        activeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        activeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
    }
}
