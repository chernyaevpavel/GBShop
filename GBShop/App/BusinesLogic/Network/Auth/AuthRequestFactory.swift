//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Павел Черняев on 20.01.2022.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(userID: String, completionHandler: @escaping (AFDataResponse<ResponseResult>) -> Void)
    func registry(userID: String,
                  userName: String,
                  password: String,
                  email: String,
                  completionHandler: @escaping (AFDataResponse<ResponseResult>) -> Void)
    func changeUserData(userID: String,
                  userName: String,
                  password: String,
                  email: String,
                  completionHandler: @escaping (AFDataResponse<ResponseResult>) -> Void)
}
