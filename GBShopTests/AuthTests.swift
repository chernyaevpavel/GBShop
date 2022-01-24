//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Павел Черняев on 24.01.2022.
//

import XCTest
import Alamofire
@testable import GBShop

class AuthTests: XCTestCase {

    let exeptation = XCTestExpectation(description: "Download")
    let requestFactory = RequestFactory()

    func testLogin() {
        let auth = self.requestFactory.makeAuthRequestFactory()
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                XCTAssert(login.result == 1)
                XCTAssert(login.user.id == 123)
                XCTAssert(login.user.name == "John")
            case .failure(let error):
                print(error)
                XCTFail()
            }
            self.exeptation.fulfill()
        }
        wait(for: [self.exeptation], timeout: 10)
    }
    
    func testLogout() {
        let auth = self.requestFactory.makeAuthRequestFactory()
        auth.logout(userID: "123") { response in
            switch response.result {
            case .success(let login):
                XCTAssert(login.result == 1)
            case .failure(let error):
                print(error)
                XCTFail()
            }
            self.exeptation.fulfill()
        }
        wait(for: [self.exeptation], timeout: 10)
    }

}
