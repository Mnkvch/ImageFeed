//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Андрей Манкевич on 10.05.2023.
//

import UIKit

final class ImagesListCell: UITableViewCell {

    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
}
