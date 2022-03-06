//
//  BannersTableCell.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import UIKit
import RxSwift
import RxCocoa


class BannersTableCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionDataSource = BehaviorRelay<[Banner]>(value: [])
    var disposeBag = DisposeBag()
    var cellActionsDisposeBag = DisposeBag()
    var itemDidSelectd = PublishSubject<Banner>()
    
    override func prepareForReuse() {
        cellActionsDisposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        bindUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI (){
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    func bindUI(){
        collectionDataSource
          .bind(to: collectionView.rx.items) { [weak self]
            (collectionView , index, element) in
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for:IndexPath(item: index, section: 0)) as! BannerCollectionViewCell
              cell.bind(item : element)
            return cell
          }
          .disposed(by: self.disposeBag)
        collectionView.rx
          .modelSelected(Banner.self)
          .subscribe(onNext: {[weak self] model in
              self?.itemDidSelectd.onNext(model)
          })
          .disposed(by: disposeBag)
    }
    
}

extension BannersTableCell {

    @objc(collectionView:layout:sizeForItemAtIndexPath:)
       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize.init(width: collectionView.frame.width, height: 160)
       }
    
}


