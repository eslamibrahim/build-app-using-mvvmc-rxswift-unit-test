//
//  SmartCollectionViewCell.swift
//  Sary flagship iOS App
//
//  Created by islam on 06/03/2022.
//

import UIKit

class SmartCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bind(item : Category) {
        lblTitle.text = item.name
        guard let url = URL(string: item.image ?? "") else {return}
        img.kf.indicatorType = .activity
        img.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "ic_logo.pdf"))
    }
}
