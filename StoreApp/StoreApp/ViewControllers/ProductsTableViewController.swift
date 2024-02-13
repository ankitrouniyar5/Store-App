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
        
        Task {
           await populateProducts()
        }
    }
    
    private func populateProducts() async {
        do {
            products = try await client.getProductsByCategory(categoryId: category.id)
            tableView.reloadData()
        }catch {
            print(error)
        }
    }
    
    @objc private func addProductBarPressed() {
       print("add was tapped")
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
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductCellView(product: product)
        })
        return cell
        
    }
    
}
