//
//  ProductInfoViewController.swift
//  GBShop
//
//  Created by Павел Черняев on 13.02.2022.
//

import UIKit

class ProductInfoViewController: UIViewController {
    
    private let product: Product
    private var reviewList: [ReviewUser] = []
    private let reviewBussinesMode = ReviewBussinesModel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getReviews(productId: self.product.id) { arr in
            self.reviewList = arr
            self.tableView.reloadData()
        }
    }
    
    private func getReviews(productId: Int, completion: ([ReviewUser]) -> () ) { //заглушка, т/к/ в API нет метода для получения отзывов)))
        var reviewList: [ReviewUser] = []
        let rU = ReviewUser(text: "Test1", user: User(id: 1, login: "login", name: "name", lastName: "last name"))
        reviewList.append(rU)
        completion(reviewList)
    }
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .systemBackground

        let nameProductLabel = UILabel()
        nameProductLabel.text = self.product.name
        nameProductLabel.font = .boldSystemFont(ofSize: 20)
        nameProductLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameProductLabel)
        
        let priceLabel = UILabel()
        priceLabel.text = "Цена \(self.product.price)"
        priceLabel.font = .systemFont(ofSize: 15)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            nameProductLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            nameProductLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            nameProductLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: nameProductLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8),

            tableView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension ProductInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ReviewUserTableViewCell(reviewUser: self.reviewList[indexPath.row])
    }
}
