//
//  SelfSizeCollectionView.swift
//  Sehatty
//
//  Created by Abdallah Ragab on 25/11/2021.
//  Copyright © 2021 Lean. All rights reserved.
//

import UIKit

class SelfSizeCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
