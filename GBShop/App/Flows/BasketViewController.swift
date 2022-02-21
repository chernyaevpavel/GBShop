//
//  BasketViewController.swift
//  GBShop
//
//  Created by Павел Черняев on 16.02.2022.
//

import UIKit

class BasketViewController: UIViewController {
    private let tabelView = UITableView()
    private var basketList: BasketList = {
        return UserDefaults.standard.getBasketList()
        
    }() {
        didSet {
            UserDefaults.standard.setBasket(basketList)
        }
    }
    
    let totalSumLabel = UILabel()
    private var totalSum: Float = 0
    private var basketArray: [BasketItem] = []
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tabelView.delegate = self
        tabelView.dataSource = self
        updateTotalSum()
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        let nibBasketCell = UINib(nibName: "BasketTableViewCell", bundle: nil)
        tabelView.register(nibBasketCell, forCellReuseIdentifier: "BasketTableViewCell")
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        totalSumLabel.translatesAutoresizingMaskIntoConstraints = false
        totalSumLabel.font = .systemFont(ofSize: 20)
        view.addSubview(self.totalSumLabel)
        
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.tabelView)
        
        let payButton = UIButton()
        payButton.setTitle("Купить", for: .normal)
        payButton.setTitleColor(.link, for: .normal)
        payButton.setTitleColor(.systemBackground, for: .highlighted)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.addTarget(self, action: #selector(payButtonClick), for: .touchUpInside)
        view.addSubview(payButton)
        
        NSLayoutConstraint.activate([
            totalSumLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            totalSumLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            totalSumLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            totalSumLabel.heightAnchor.constraint(equalToConstant: 20),
            
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            payButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -32),
            payButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
            payButton.heightAnchor.constraint(equalToConstant: 40),
            
            tabelView.topAnchor.constraint(equalTo: totalSumLabel.bottomAnchor, constant: 8),
            tabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabelView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -16),
            
        ])
    }
    
    private func updateTotalSum() {
        totalSum = basketList.reduce(0) { partialResult, basketItem in
            partialResult + basketItem.count * basketItem.product.price
        }
        totalSumLabel.text = "Сумма заказа: \(String(totalSum))"
    }
    
    @objc
    func payButtonClick() {
        if isEmptyBasket() {
            print("Корзина пуста")
            return
        }
        
        let basketBM = BasketBussinesModel()
        basketBM.send(.payBasket) { response in
            print(response.result)
        }
        basketList = []
        let allert = UIAlertController(title: "GBShop", message: "Покупка успешно оформлена", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        allert.addAction(action)
        present(allert, animated: true)
    }
    
    private func isEmptyBasket() -> Bool {
        guard let _ = basketList.first(where: { basketItem in
            basketItem.count > 0
        }) else { return true }
        return false
    }
    
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        basketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basketItem = basketList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell") as? BasketTableViewCell {
            cell.configure(basketItem)
            cell.basketAction = { [weak self] (sender, typeBasketAction) in
                let idProduct = sender.tag
                guard let index = self?.basketList.firstIndex(where: { basketItem in
                    basketItem.product.id == idProduct
                }) else { return}
                
                switch typeBasketAction {
                case .add:
                    self?.basketList[index].count += 1
                case .reduce:
                    if self?.basketList[index].count == 0 { return }
                    self?.basketList[index].count -= 1
                }
                self?.tabelView.reloadData()
                self?.updateTotalSum()
            }
            return cell
        }
        return UITableViewCell()
    }
}
