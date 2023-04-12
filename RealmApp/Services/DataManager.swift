//
//  DataManager.swift
//  RealmApp
//
//  Created by Alexey Efimov on 08.10.2021.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            // add list 1
            let shoppingList = TaskList()
            shoppingList.name = "Shopping List"
            // add task 1a
            let milk = Task()
            milk.name = "Milk"
            milk.note = "2L"
            shoppingList.tasks.append(milk)
            // 1b
            let bread = Task(value: ["Bread", "", Date(), true])
            // 1c
            let apples = Task(value: ["name": "Apples", "note": "2Kg"])
            shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
            
            // 2
            let moviesList = TaskList(
                value: [
                    "Movies List",
                    Date(),
                    [
                        ["Best film ever"],
                        ["The best of the best", "Must have", Date(), true]
                    ]
                ]
            )
            
            // async save lists
            DispatchQueue.main.async {
                StorageManager.shared.save([shoppingList, moviesList])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
}
