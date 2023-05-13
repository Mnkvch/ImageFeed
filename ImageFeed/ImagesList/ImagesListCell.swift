//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 10.05.2023.
//

import Foundation
import UIKit

final class ImagesListCell: UITableViewCell {

    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
}
