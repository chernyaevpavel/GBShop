//
//  DataRequest.swift
//  GBShop
//
//  Created by Павел Черняев on 20.01.2022.
//

import Foundation
import Alamofire

class CustomDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {
    
    private let errorParser: AbstractErrorParser
    
    init(errorParser: AbstractErrorParser) {
        self.errorParser = errorParser
    }
    
    func serialize(request: URLRequest?,
                   response: HTTPURLResponse?,
                   data: Data?,
                   error: Error?) throws -> T {
        if let error = self.errorParser.parse(response: response, data: data, error: error) {
            throw error
        }
        do {
            let data = try DataResponseSerializer().serialize(request: request, response: response, data: data, error: error)
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            let customError = self.errorParser.parse(error)
            throw customError
        }
    }
}

extension DataRequest {
    func resposeCadable<T: Decodable> (errorParser: AbstractErrorParser,
                                       queue: DispatchQueue = .main,
                                       completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        let responseSerializer = CustomDecodableSerializer<T>(errorParser: errorParser)
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
