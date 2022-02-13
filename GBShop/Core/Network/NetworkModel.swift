//
//  NetworkModel.swift
//  GBShop
//
//  Created by Павел Черняев on 08.02.2022.
//

import Foundation
import Alamofire

protocol NetworkModel {
    associatedtype T
    associatedtype U
    
    func send(_: T, completion: @escaping (AFDataResponse<U>) -> Void)
}
