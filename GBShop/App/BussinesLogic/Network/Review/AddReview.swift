//
//  AddReview.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import Foundation
import Alamofire

class AddReview: AbstactRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    let baseURL = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension AddReview: AddReviewRequestFactory {
    func addReview(userId: Int, textReview: String, completion: @escaping (AFDataResponse<ResultUserMessage>) -> Void) {
        let requestModel = AddReviewStruct(baseURL: baseURL, userId: userId, textReview: textReview)
        self.request(request: requestModel, completionHandler: completion)
        
    }
}

extension AddReview {
    struct AddReviewStruct: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "addReview.json"
        let userId: Int
        let textReview: String
        var parameters: Parameters? {
            return ["id_user": userId, "text": textReview]
        }
    }
}
