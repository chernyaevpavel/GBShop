//
//  UserDefaults.swift
//  GBShop
//
//  Created by Павел Черняев on 17.02.2022.
//

import Foundation

typealias BasketList = [BasketItem]

extension UserDefaults {

    func setBasket(_ basketList: BasketList) {
        let data = try? JSONEncoder().encode(basketList)
        UserDefaults.standard.set(data, forKey: Const.shared.basketKey)
    }
    
    func getBasketList() -> BasketList {
        var basketList: BasketList = []
        if let data = UserDefaults.standard.data(forKey: Const.shared.basketKey) {
            if let decodeData = try? JSONDecoder().decode(BasketList.self, from: data) {
                basketList = decodeData
            }
        }
        return basketList
    }

    
}



