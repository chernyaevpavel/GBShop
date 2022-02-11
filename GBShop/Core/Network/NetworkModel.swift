//
//  NetworkModel.swift
//  GBShop
//
//  Created by Павел Черняев on 08.02.2022.
//

import Foundation

protocol NetworkModel {
    associatedtype T
    func send(_: T)
}
