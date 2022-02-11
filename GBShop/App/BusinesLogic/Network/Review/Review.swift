//
//  Review.swift
//  GBShop
//
//  Created by Павел Черняев on 27.01.2022.
//

import Foundation
import Alamofire

class Review: AbstactRequestFactory {
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

extension Review: ReviewRequestFactory {
    
    func addReview(userId: Int, textReview: String, completion: @escaping (AFDataResponse<ResultUserMessage>) -> Void) {
        let requestModel = AddReview(baseURL: baseURL, userId: userId, textReview: textReview)
        self.request(request: requestModel, completionHandler: completion)
        
    }
    
    func approveReview(idComment: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = ApproveReview(baseURL: baseURL, idComment: idComment)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func deleteReview(idComment: Int, completion: @escaping (AFDataResponse<ResponseResult>) -> Void) {
        let requestModel = DeleteReview(baseURL: baseURL, idComment: idComment)
        self.request(request: requestModel, completionHandler: completion)
    }
}

extension Review {
    struct AddReview: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "addReview.json"
        let userId: Int
        let textReview: String
        var parameters: Parameters? {
            return ["id_user": userId, "text": textReview]
        }
    }
    
    struct ApproveReview: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "approveReview.json"
        let idComment: Int
        var parameters: Parameters? {
            return ["id_comment": idComment]
        }
    }
    
    struct DeleteReview: RequestRouter {
        let baseURL: URL
        let method: HTTPMethod = .get
        let path: String = "removeReview.json"
        let idComment: Int
        var parameters: Parameters? {
            return ["id_comment": idComment]
        }
    }
}

