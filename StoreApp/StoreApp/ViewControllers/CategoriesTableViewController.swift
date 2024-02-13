//
//  CategoriesTableViewController.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import UIKit

internal final class CategoriesTableViewController: UITableViewController {

    private var client = StoreHTTPClient()
    private var categories: [Category] = []
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        
        Task {
            await populateCategories()
            tableView.reloadData()
        }
    }
    
    private func populateCategories() async {
        
        do {
            categories = try await client.getAllCategories()
        } catch {
            showAlert(title: "Error", message: "Unable to fetch categories")
        }
    }
    
    override internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = category.name
        
        if let url = URL(string: category.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        configuration.image = image
                        configuration.imageProperties.maximumSize = CGSize(width: 75, height: 75)
                        cell.contentConfiguration = configuration
                        
                    }
                }
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        self.navigationController?.pushViewController(ProductsTableViewController(category: category), animated: true)
    }

}

