//
//  BannerCollectionViewCell.swift
//  Sary flagship iOS App
//
//  Created by islam on 06/03/2022.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(item : Banner) {
        guard let url = URL(string: item.image ?? "") else {return}
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "ic_logo.pdf"))
    }
    func bind(item : Category) {
        guard let url = URL(string: item.image ?? "") else {return}
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "ic_logo.pdf"))
    }
}
