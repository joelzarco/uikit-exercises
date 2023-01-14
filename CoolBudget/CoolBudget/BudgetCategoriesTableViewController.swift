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
        view.backgroundColor = .systemPink
    }
}
