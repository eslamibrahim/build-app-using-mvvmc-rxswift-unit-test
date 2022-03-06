//
//  SelfSizedTableView.swift
//  Sehatty
//
//  Created by abdallah ragab on 20/01/2021.
//  Copyright © 2021 Lean. All rights reserved.
//

import Foundation
import UIKit

open class SelfSizedTableView: UITableView {
    open override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

class SelfSizedNestedTableView: UITableView {
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    open override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = min(contentSize.height, self.maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
