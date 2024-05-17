//
//  ProductList_VC.swift
//  MVVM
//
//  Created by SMIT iMac27 on 17/05/24.
//

import UIKit

class ProductList_VC: UIViewController {

    @IBOutlet weak var product_TV : UITableView!
    private var viewModel = Product_ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configration()
    }
    

}

extension ProductList_VC {
    
    func configration() {
        product_TV.register(UINib(nibName: "ProductCell_TVC", bundle: nil), forCellReuseIdentifier: "ProductCell_TVC")
        initViewModel()
        observeEvent()
    }
    
    func initViewModel() {
        viewModel.fetchProducts()
    }
    
    // Data binding event observe -> Communications
    // memory and not sure for event is nil or not `weak self`
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .loading : break
            case .stopLoading : break
            case .dataLoaded :
                DispatchQueue.main.async {
                    // Ui related work in Main 
                    self.product_TV.reloadData()
                }
            case .error(let error) :
                print(error)
            }
        }
    }
}

extension ProductList_VC : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell_TVC") as? ProductCell_TVC else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
                return cell
    }
}
