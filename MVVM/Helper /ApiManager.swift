//
//  ApiManager.swift
//  MVVM
//
//  Created by SMIT iMac27 on 17/05/24.
//

import Foundation

//typealias -> used for closure and long resultes because write to hard
typealias Handler = (Result<[Product], DataError>) -> Void


//Singleton Dessign Pattern ( not creating any obj nor can be inheritant the property of Class usinh `final`
final class ApiManager  {
    
    static let shared = ApiManager()
    private init() {}
    
    func fetchProducts(complition: @escaping Handler ) {
        
        guard let url = URL(string: Constant.API.productURl) else {
            complition(.failure(.invalidURL))
            return
        }
        
        
        // When first time this function is called it isn't go in the below block -> it's only get the url after this it's exit the func
        // after this it's checking ur internet and go tho below block
        // beacuse below block is call after end the func that's way we using `@escaping` because we use conplition in the scope of the below block otherwise it's giving the error
        // if my func. is called line by line than we don't use `@escaping` but now its mandatry becuase its calling after exit the func
        // `@escaping` capture (store) the complition in the memory
        // working in the background (Task)
        // `complition` called before exiting the func , if u user `complition` than need `@escaping`
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil  else {
                complition(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse ,
                  200 ... 299 ~= response.statusCode else {
                complition(.failure(.invalidResponse))
                return
            }
            
            do {
                // JSONDecoder() -> covert the data into model
                let product = try JSONDecoder().decode([Product].self, from: data)
                complition(.success(product))
            }catch {
                complition(.failure(.network(error)))
            }
            
        }.resume()
        // `resume` -> Resumes the task, if it is suspended
        
    }
    
}












// MARK: - Demo for Closure , final , static , `s` , `S` singleton class
/*
final class A  {
    
    static let shared = A()

//    smarl `s` -> singleton ( you can create object outside of the class)
//    init(){}  -> init is a Closure
//     capital `S` -> Singleton ( you can't create any object outside of the class , obj only created in the classs
    private init() {}
    func temp(){
        
    }
}

class B {
    func configration(){
//        let url  = URLSession() small `s` example of singleon class
//         small s -> singleton class ka object create hoga outside of the class . same as give below
//        let manager = A() //'A' initializer is inaccessible due to 'private' protection level
//        manager.temp()

//          without creating any object we can use the property of the class because of static keyword and shared is already an object
        A.shared.temp()
    }
}


// C inherit the property of A
class C : A {
    // using the `final` keyword to stop inheritance
    // Inheritance from a final class 'A'
    // Instance method overrides a 'final' instance method
    override func temp() {
        <#code#>
    }
}

*/
