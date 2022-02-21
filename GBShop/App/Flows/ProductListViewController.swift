//
//  ProductListViewController.swift
//  GBShop
//
//  Created by Павел Черняев on 12.02.2022.
//

import UIKit

class ProductListViewController: UIViewController {
    
    private var produstList: [Product] = []
    private let productBussinesModel = ProductBussinesModel()
    private let imageTrash = UIImage(systemName: "trash")
    private let imageTrashSlash = UIImage(systemName: "trash.slash")
    let tableView = UITableView()
    
    private var basketList: BasketList = {
        return UserDefaults.standard.getBasketList()
    }() {
        didSet {
            UserDefaults.standard.setBasket(basketList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getProductList()
    }
    
    private func getProductList() {
        productBussinesModel.send(.getProductList) { response in
            switch response.result {
            case .success(let productList):
                DispatchQueue.main.async {
                    self.produstList = productList
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        let buttonBasket = UIButton(type: .custom)
        buttonBasket.setImage(self.imageTrash, for: .normal)
        buttonBasket.translatesAutoresizingMaskIntoConstraints = false
        buttonBasket.addTarget(self, action: #selector(buttonBasketClick), for: .touchUpInside)
        view.addSubview(buttonBasket)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            buttonBasket.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            buttonBasket.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            buttonBasket.heightAnchor.constraint(equalToConstant: 40),
            buttonBasket.widthAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: buttonBasket.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        
    }
    
    @objc
    func buttonBasketClick() {
        let basketVC = BasketViewController()
        present(basketVC, animated: true, completion: nil)
    }
    
    @objc
    func addToBasket(sender: UIButton) {
        let row = sender.tag
        let idProduct = self.produstList[row].id
        if let index = basketList.firstIndex(where: { basketItem in
            basketItem.product.id == idProduct
        }) {
            basketList.remove(at: index)
        }
         else {
             basketList.append(BasketItem(product: self.produstList[row], count: 1))
        }
        
        self.tableView.reloadData()
    }
}


extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        produstList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.produstList[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = String(product.price)
        cell.tag = product.id
        let btnBasket = UIButton()
        
        if basketList.contains { basketItem in
            basketItem.product.id == product.id
        } {
            btnBasket.setImage(self.imageTrashSlash, for: .normal)
        } else {
            btnBasket.setImage(self.imageTrash, for: .normal)
        }
        
        
        
        btnBasket.translatesAutoresizingMaskIntoConstraints = false
        btnBasket.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
        btnBasket.tag = indexPath.row
        cell.addSubview(btnBasket)
        NSLayoutConstraint.activate([
            btnBasket.topAnchor.constraint(equalTo: cell.topAnchor),
            btnBasket.rightAnchor.constraint(equalTo: cell.rightAnchor),
            btnBasket.widthAnchor.constraint(equalToConstant: 50),
            btnBasket.heightAnchor.constraint(equalToConstant: 50)
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.produstList[indexPath.row]
        let productInfoVC = ProductInfoViewController(product: product)
        present(productInfoVC, animated: true, completion: nil)
    }
    
    
}
