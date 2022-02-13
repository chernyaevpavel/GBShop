//
//  ReviewBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 11.02.2022.
//

import Foundation
import Alamofire

class ReviewBussinesModel: NetworkModel {
    
    private let requestFactory = RequestFactory()
    
    func send(_ reviewFunction: ReviewFunction, completion: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let reviewRequestFactory = self.requestFactory.makeReviewRequestFactory()
        
        switch reviewFunction {
        case .approveReview:
            let idComment = 123
            reviewRequestFactory.approveReview(idComment: idComment, completion: completion)
        case .deleteReview:
            let idComment = 123
            reviewRequestFactory.deleteReview(idComment: idComment, completion: completion)
        }
    }
}
