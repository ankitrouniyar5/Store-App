//
//  AddProductViewController.swift
//  StoreApp
//
//  Created by Ankit Rouniyar on 13/02/24.
//

import Foundation
import UIKit
import SwiftUI

protocol AddProductViewControllerDelegate {
    func addProductViewControllerDidCancel(controller: AddProductViewController)
    func addProductViewControllerDidSave(product: Product, controller: AddProductViewController)
}

internal final class AddProductViewController: UIViewController {
    private var selectedCategory: Category?
    var delegate: AddProductViewControllerDelegate?
    
    
    internal lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        return button
    }()
    
    internal lazy var saveBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(saveButtonPressed))
        return button
    }()
    
    internal lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    internal lazy var descriptionTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.contentInsetAdjustmentBehavior = .automatic
        return textView
    }()
    
    internal lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter price"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    internal lazy var categoryPickerView: CategoryPickerView = {
        let pickerView = CategoryPickerView { [weak self] category in
            self?.selectedCategory = category
        }
        return pickerView
    }()
    
    internal lazy var imageURLTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter image URL"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = saveBarButton
        
        setupUI()
    }
    
    //MARK: Helper Functions
    
    @objc private func cancelButtonPressed() {
        delegate?.addProductViewControllerDidCancel(controller: self)
        
    }
    
    @objc private func saveButtonPressed() {
        guard let title = titleTextField.text,
              let price = Double(priceTextField.text ?? "0.00"),
              let description = descriptionTextView.text,
              let imageURL = imageURLTextField.text,
              let category = selectedCategory
        else { return }
        
        let product = Product(title: title, price: price, description: description, images: [imageURL], category: category)
        
        delegate?.addProductViewControllerDidSave(product: product, controller: self)
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(priceTextField)
        stackView.addArrangedSubview(descriptionTextView)
        
        let hoistingController = UIHostingController(rootView: categoryPickerView)
        stackView.addArrangedSubview(hoistingController.view)
        addChild(hoistingController)
        hoistingController.didMove(toParent: self)
        stackView.addArrangedSubview(imageURLTextField)
        
        view.addSubview(stackView)
        
        //constraints
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

#Preview {
    UINavigationController(rootViewController: AddProductViewController())
    
}
