//
//  ReviewBussinesModel.swift
//  GBShop
//
//  Created by Павел Черняев on 11.02.2022.
//

import Foundation

class ReviewBussinesModel: NetworkModel {
    
    private let requestFactory = RequestFactory()
    
    func send(_ reviewFunction: ReviewFunction) {
        let reviewRequestFactory = self.requestFactory.makeReviewRequestFactory()
        
        switch reviewFunction {
        case .addReview:
            reviewRequestFactory.addReview(userId: 123, textReview: "test") { response in
                switch response.result {
                case .success(let result):
                    print("add \(result)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .approveReview:
            reviewRequestFactory.approveReview(idComment: 123) { response in
                switch response.result {
                case .success(let result):
                    print("approve \(result)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .deleteReview:
            reviewRequestFactory.deleteReview(idComment: 123){ response in
                switch response.result {
                case .success(let result):
                    print("delete \(result)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}
