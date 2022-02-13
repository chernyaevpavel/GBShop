//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import Foundation
import Alamofire

protocol AddReviewRequestFactory {
    func addReview(userId: Int, textReview: String, completion: @escaping (AFDataResponse<ResultUserMessage>) -> Void )
}
