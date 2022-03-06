//
//  CollectionViewContainerTableCell.swift
//  Sary flagship iOS App
//
//  Created by islam on 05/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BannersTableCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionDataSource = BehaviorRelay<[Codable]>(value: [])
    let disposeBag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindUI(){
        collectionDataSource
          .bind(to: collectionView.rx.items) { [weak self]
            (collectionView , index, element) in
              let data = ((self?.groupData as? Group) != nil) ? (self?.groupData as? Group) : (self?.groupData as? Banner)
              
              switch GroupDataType(rawValue: data.dataType) {
              case <#pattern#>:
                  <#code#>
              default:
                  <#code#>
              }
              
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: )
            return cell
          }
          .disposed(by: self.disposeBag)
    }
    
}


