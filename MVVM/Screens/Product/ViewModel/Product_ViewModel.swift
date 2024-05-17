//
//  Product_ViewModel.swift
//  MVVM
//
//  Created by SMIT iMac27 on 17/05/24.
//

import Foundation

final class Product_ViewModel {
    
    var products: [Product] = []
    var eventHandler: ((_ event : Events) -> Void )? // Data Binding Closure to loading and get the data 
    
    func fetchProducts(){
        
        self.eventHandler?(.loading)
        ApiManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let product):
                self.products = product
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error ))
            }
        }
    }
    
}



extension Product_ViewModel {   
    enum Events {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
