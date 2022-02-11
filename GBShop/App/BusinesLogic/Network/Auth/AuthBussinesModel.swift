//
//  AuthBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 08.02.2022.
//

import Foundation

class AuthBussinesModel: NetworkModel {
    
    private let requestFactory = RequestFactory()
    
    func send(_ authFunction: AuthFunction) {
        let auth = requestFactory.makeAuthRequestFactory()
        
        switch authFunction {
        case .login:
            auth.login(userName: "Somebody", password: "mypassword") { response in
                switch response.result {
                case .success(let login):
                    print(login)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .logout:
            auth.logout(userID: "123") { response in
                switch response.result {
                case .success(let logout):
                    print("logout \(logout)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .registry:
            auth.registry(userID: "123", userName: "123", password: "123", email: "123") { response in
                switch response.result {
                case .success(let logout):
                    print("registry \(logout)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .changeUserData:
            auth.changeUserData(userID: "123", userName: "123", password: "123", email: "123") { response in
                switch response.result {
                case .success(let logout):
                    print("changeUserData \(logout)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
}
