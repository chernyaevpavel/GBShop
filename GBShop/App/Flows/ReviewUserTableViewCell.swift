//
//  ReviewUserTableViewCell.swift
//  GBShop
//
//  Created by Павел Черняев on 14.02.2022.
//

import UIKit

class ReviewUserTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init(reviewUser: ReviewUser) {
        super.init(style: .subtitle, reuseIdentifier: nil)
        
        self.textLabel?.text = reviewUser.text
        self.detailTextLabel?.text = reviewUser.user.name
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
