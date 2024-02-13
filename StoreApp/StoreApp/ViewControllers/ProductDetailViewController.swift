//
//  ProductDetailViewController.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation
import UIKit
import SwiftUI

internal final class ProductDetailViewController : UIViewController {
    
    private let product: Product
    private let client = StoreHTTPClient()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var deleteProductButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        return button
    }()
    
    internal init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = product.title
        setupUI()
    }
    
    private func setupUI() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        stackView.alignment = .top
        
        descriptionLabel.text = product.description
        priceLabel.text = "Rs. " + String(product.price)
        
        Task {
            var images: [UIImage] = []
            for image in product.sanitizedImages ?? [] {
                guard let downloadedImages = await ImageLoader.load(url: URL(string: image)) else {
                    return
                }
                images.append(downloadedImages)
            }
            let productImagesListVC = UIHostingController(rootView: ProductImagesListView(images: images))
            guard let productImagesListView = productImagesListVC.view else { return }
            stackView.insertArrangedSubview(productImagesListView, at: 0)
            self.addChild(productImagesListVC)
            productImagesListVC.didMove(toParent: self)
     
        }
        
        deleteProductButton.addTarget(self, action: #selector(deleteProductButtonPressed), for: .touchUpInside)
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(deleteProductButton)
        
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    @objc private func deleteProductButtonPressed(_ sender: UIButton) {
        Task {
            do {
                guard let productId = product.id  else { return }
                let isDeleted = try await client.deleteProduct(productId: productId)
                if isDeleted {
                    let _ = navigationController?.popViewController(animated: true)
                }
            } catch {
                print(error)
            }
        }
        
    }
}
