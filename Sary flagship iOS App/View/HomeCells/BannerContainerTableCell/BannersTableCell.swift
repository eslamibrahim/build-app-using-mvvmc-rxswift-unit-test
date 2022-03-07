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
    
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionDataSource = BehaviorRelay<[Banner]>(value: [])
    var disposeBag = DisposeBag()
    var itemDidSelectd : ((Banner)->Void)?
    var timer = Timer()
    var counter = 0
    
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
        collectionView.showsHorizontalScrollIndicator = false
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
                self?.itemDidSelectd?(model)
            })
            .disposed(by: disposeBag)
    }
    
    func buildSlider(){
        pageView.numberOfPages = collectionDataSource.value.count
        pageView.currentPage = 0
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
        self.timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
            if self.counter < self.collectionDataSource.value.count {
                let index = IndexPath.init(item: self.counter, section: 0)
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: index, at: .left, animated: false)
                self.collectionView.isPagingEnabled = true
                self.pageView.currentPage = self.counter
                self.counter += 1
            } else {
                self.counter = 0
                let index = IndexPath.init(item: self.counter, section: 0)
                self.collectionView.isPagingEnabled = false
                self.collectionView.scrollToItem(at: index, at: .left, animated: false)
                self.collectionView.isPagingEnabled = true
                self.pageView.currentPage = self.counter
                self.counter = 1
            }
    }
    
    deinit {
        timer.invalidate()
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


