//
//  DataManager.swift
//  RealmApp
//
//  Created by Anikin Ilya on 13.10.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createTempData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "done") {
            let shoppingList = TaskList()
            shoppingList.name = "Shopping List"
            
            let milk = Task(value: ["name": "Milk","note": "2L"])
            let bread = Task(value: ["name": "Bread", "isComplete": true])
            let apples = Task(value: ["name": "Apples", "note": "2 kg", ])
            
            shoppingList.tasks.insert(contentsOf: [milk, bread, apples], at: 0)
            
            let moviesList = TaskList()
            moviesList.name = "Movies List"
            
            let bestFilmEver = Task(value: ["name": "Best film ever"])
            let theBestOfTheBestFilm = Task(value: [
                "name": "The best of the best",
                "note": "Must have",
                "isComplete": true
            ])
            
            moviesList.tasks.insert(contentsOf: [bestFilmEver, theBestOfTheBestFilm], at: 0)
            
            DispatchQueue.main.async {
                StorageManager.shared.save([shoppingList, moviesList])
                UserDefaults.standard.set(true, forKey: "done")
                completion()
            }
        }
    }
}
