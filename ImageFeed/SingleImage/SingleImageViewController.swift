//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 21.05.2023.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            singleImage.image = image
        }
    }
    
    @IBOutlet weak var singleImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleImage.image = image
    }
    
    
}
