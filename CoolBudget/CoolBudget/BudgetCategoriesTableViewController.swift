//
//  BudgetCategoriesTableViewController.swift
//  CoolBudget
//
//  Created by Johel Zarco on 13/01/23.
//

import Foundation
import UIKit
import CoreData

class BudgetCategoriesViewController : UITableViewController{
    
    private var persistentContainer : NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    @objc func showAddBudgetCategory(_ sender : UIBarButtonItem){
        print("bar button tapped")
        let navController = UINavigationController(rootViewController: AddCategoryViewController(persistentContainer: persistentContainer))
        present(navController, animated: true)
    }
    
    private func setupUI(){
        
        let addBudgetCategoryButton = UIBarButtonItem(title: "Add category", style: .done, target: self, action: #selector(showAddBudgetCategory))
        self.navigationItem.rightBarButtonItem = addBudgetCategoryButton
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Budget"
    }
}
