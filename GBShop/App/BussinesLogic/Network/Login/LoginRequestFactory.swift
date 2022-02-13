//
//  LoginRequestFactory.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import Foundation
import Alamofire

protocol LoginRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
