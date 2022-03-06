//
//  ContainerCollectionViewTableViewCell.swift
//  Sary flagship iOS App
//
//  Created by islam on 06/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ContainerCollectionViewTableViewCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: SelfSizeCollectionView!
    var collectionDataSource = BehaviorRelay<[Category]>(value: [])
    var groupData : Group!{
        didSet {
            if groupData.showTitle ?? false {
                lblTitle.text = groupData.title
            }else{
                lblTitle.text = nil
            }
            if GroupDataType(rawValue: groupData.dataType ?? "")  == .group {
                if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .vertical
                    collectionView.isScrollEnabled = false
                }
            }
        }
    }
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI ()
        bindUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI (){
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        collectionView.register(UINib(nibName: "SmartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SmartCollectionViewCell")
        collectionView.register(UINib(nibName: "GroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GroupCollectionViewCell")
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindUI(){
        collectionDataSource
            .bind(to: collectionView.rx.items) { [weak self]
                (collectionView , index, element) in
                switch GroupDataType(rawValue: self?.groupData.dataType ?? "") {
                case .group:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for:IndexPath(item: index, section: 0)) as! GroupCollectionViewCell
                    cell.bind(item : element)
                    return cell
                case .banner:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for:IndexPath(item: index, section: 0)) as! BannerCollectionViewCell
                    cell.bind(item: element)
                    return cell
                case .smart :
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmartCollectionViewCell", for:IndexPath(item: index, section: 0)) as! SmartCollectionViewCell
                    cell.bind(item : element)
                    return cell
                case .none:
                    return UICollectionViewCell()
                }
            }
            .disposed(by: self.disposeBag)
        
    }
}


extension ContainerCollectionViewTableViewCell : UICollectionViewDelegateFlowLayout{
    
    @objc(collectionView:layout:sizeForItemAtIndexPath:)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfSets = CGFloat(self.groupData.rowCount ?? 0)
        
        let width = (collectionView.frame.size.width  / numberOfSets) - 10
        
        let height = 109.0
        
        return CGSize(width: width, height: height)
    }
    
}


