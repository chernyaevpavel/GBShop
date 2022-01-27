//
//  ReviewRequestFactory.swift
//  GBShop
//
//  Created by Павел Черняев on 27.01.2022.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {
    func addReview(userId: Int, textReview: String, completion: @escaping (AFDataResponse<ResultUserMessage>) -> Void )
    func approveReview(idComment: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void)
    func deleteReview(idComment: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void)
}
