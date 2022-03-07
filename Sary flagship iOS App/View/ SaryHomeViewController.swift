//
//   SaryHomeViewController.swift
//  Sary flagship iOS App
//
//  Created by islam on 02/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class  SaryHomeViewController: UIViewController {
    
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var tableView: SelfSizedNestedTableView!
    var viewModel : SaryHomeDashboardViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getSaryHomeUIInfo()
        setupUI ()
        bindUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI (){
        tableView.register(UINib(nibName: "BannersTableCell", bundle: nil), forCellReuseIdentifier: "BannersTableCell")
        tableView.register(UINib(nibName: "ContainerCollectionViewTableViewCell", bundle: nil), forCellReuseIdentifier: "ContainerCollectionViewTableViewCell")
        
        self.activityLoading.hidesWhenStopped = true
    }
    
    func bindUI(){

        viewModel.tableViewItemsData.bind(to: tableView.rx.items) { [weak self]
            (tableView , index, element) in
            if let data = element.banners {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BannersTableCell", for:IndexPath(row: index, section: 0)) as! BannersTableCell
                cell.collectionDataSource.accept(data)
                cell.itemDidSelectd = {[weak self] item in
                    self?.showAlert(message : item.link ?? "")
                }
                cell.buildSlider()
                return cell
            }else if let data = element.categoriesGroups {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ContainerCollectionViewTableViewCell", for:IndexPath(row: index, section: 0)) as! ContainerCollectionViewTableViewCell
                cell.groupData = data
                cell.collectionDataSource.accept(data.data ?? [])
                return cell
            }else {
                return UITableViewCell()
            }
        }
        .disposed(by: self.disposeBag)
        
        viewModel.loading.bind { load in
            if let isloading = load {
                isloading ? self.activityLoading.startAnimating() : self.activityLoading.stopAnimating()
            }
        }.disposed(by: self.disposeBag)
        
        viewModel.didRefreshRootTable.bind { [weak self] isRefreshedBefore in
            if let isRefreshed = isRefreshedBefore , !isRefreshed{
                self?.tableView.reloadData()
            }
        }.disposed(by: self.disposeBag)
    }
    
    func showAlert (message : String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}



