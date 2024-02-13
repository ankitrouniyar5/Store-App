//
//  ProductsTableViewController.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation
import UIKit
import SwiftUI

internal final class ProductsTableViewController: UITableViewController {
   
    private var category: Category
    private let client = StoreHTTPClient()
    private var products: [Product] = []
    
    internal lazy var addProductBarItemButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductBarPressed))
        return button
    }()
    
    internal init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        navigationItem.rightBarButtonItem = addProductBarItemButton
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductsTableViewCell")
    }
    
    override internal func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
           await populateProducts()
        }
    }
    
    private func populateProducts() async {
        do {
            products = try await client.getProductsByCategory(categoryId: category.id)
            tableView.reloadData()
        }catch {
            showAlert(title: "Error", message: "Unable to fetch products")
        }
    }
    
    @objc private func addProductBarPressed() {
        let addProductVC = AddProductViewController()
        addProductVC.delegate = self
        let navigationController = UINavigationController(rootViewController: addProductVC)
        present(navigationController, animated: true)
    }
    
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath)
        let product = products[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductCellView(product: product)
        })
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        self.navigationController?.pushViewController(ProductDetailViewController(product: product), animated: true)
    }
    
}

extension ProductsTableViewController: AddProductViewControllerDelegate {
    func addProductViewControllerDidCancel(controller: AddProductViewController) {
        controller.dismiss(animated: true)
    }
    
    func addProductViewControllerDidSave(product: Product, controller: AddProductViewController) {
        let createProductRequest = CreateProductRequest(product: product)
        Task {
            do {
                let newProduct = try await client.createProduct(productRequest: createProductRequest)
                products.insert(newProduct, at: 0)
                tableView.reloadData()
                controller.dismiss(animated: true)
            } catch {
                showAlert(title: "Error", message: "Unable to add categories")
            }
        }
        
    }
}
