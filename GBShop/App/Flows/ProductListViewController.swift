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
    let tableView = UITableView()
    
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
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
          
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.produstList[indexPath.row]
        let productInfoVC = ProductInfoViewController(product: product)
        present(productInfoVC, animated: true, completion: nil)
    }
    
    
}
