//
//  AddReviewBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import Foundation
import Alamofire


class AddReviewBussinesModel: NetworkModel {
    
    private let requestFactory = RequestFactory()
    
    func send(_ addReviewFunction: AddReviewFunction, completion: @escaping (AFDataResponse<ResultUserMessage>) -> Void) {
        let addReviewRequestFactory = requestFactory.makeAddReviewRequestFactory()
        
        switch addReviewFunction {
        case .addReview:
            let userId = 123
            let textReview = "test"
            addReviewRequestFactory.addReview(userId: userId, textReview: textReview, completion: completion)
        }
    }
}
