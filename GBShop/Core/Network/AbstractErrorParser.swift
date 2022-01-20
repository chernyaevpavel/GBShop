//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Павел Черняев on 20.01.2022.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
