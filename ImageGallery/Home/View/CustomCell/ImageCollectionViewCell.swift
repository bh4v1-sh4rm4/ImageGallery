//
//  ImageCollectionViewCell.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 21/10/24.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cellimage: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure (imageURL: String, profileURL: String, name: String, username: String) {
        cellimage.sd_setImage(with: URL(string: imageURL))
        profileImg.sd_setImage(with: URL(string: profileURL))
        lblName.text = name
        lblUsername.text = "@\(username)"
    }
}
