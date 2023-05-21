//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 18.05.2023.
//

import UIKit

final class ProfileViewConroller: UIViewController {
    
    
    @IBOutlet weak var Avatar: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var loginLadel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func TapLogoutButton(_ sender: Any) {
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
}
}
