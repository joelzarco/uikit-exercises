//
//  AddCategoryViewController.swift
//  CoolBudget
//
//  Created by Johel Zarco on 13/01/23.
//

import Foundation
import UIKit
import CoreData

class AddCategoryViewController : UIViewController{
    
    private var persistentContainer : NSPersistentContainer
    
    let spacing : CGFloat = 20
    
    lazy var nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Category name"
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var amountTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var addButton : UIButton = {
        
        let button = UIButton()
        button.configuration = .bordered()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    lazy var errorMessageLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Add budget"
        
        setUpUI()
    }
    // Save to coreData
    private func saveBudgetCategory(){
        
        guard let name = nameTextField.text, let amount = amountTextField.text else { return }
        
        do{
            // BudgetCategory as defined in BudgetModel in coreData
            let budgetCategory = BudgetCategory(context: persistentContainer.viewContext)
            budgetCategory.name = name
            budgetCategory.amount = Double(amount) ?? 0.0
            try persistentContainer.viewContext.save() // needs to be done with a try
            print("cool coreData ")
            dismiss(animated: true)
        }
        catch{
            errorMessageLabel.text = "Unable to save budget category"
        }
        
    }
    
    private var isFormValid : Bool{
        guard let name = nameTextField.text, let amount = amountTextField.text else{
            return false
        }
        // check following conditions and implement neccessary methods
        return !name.isEmpty && !amount.isEmpty && amount.isNumeric && amount.isGreaterThan(0)
    }
    
    @objc func addButtonPressed(_ sender : UIButton){
        print("add button pressed")
        // call validation
        if( isFormValid){
            // implement methods to save in coreData
            print("Saving to core data")
            saveBudgetCategory()
        } else{
            errorMessageLabel.text = "Unable to save budget."
        }
        
    }
    private func setUpUI(){
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(errorMessageLabel)
        
        nameTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -2 * spacing).isActive = true
        amountTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -2 * spacing).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .primaryActionTriggered)
        
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
}
