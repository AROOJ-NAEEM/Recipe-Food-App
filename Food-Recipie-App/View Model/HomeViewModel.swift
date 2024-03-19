//
//  HomeViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import Foundation

class HomeViewModel {
    private let dbManager = DatabaseManager.shared
    func fetchName(completion: @escaping (String?) -> Void) {
        dbManager.fetchName { name in
            completion(name)
        }
    }
    
    func loadRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        dbManager.loadRecipes { recipes, error in
            completion(recipes, error)
        }

    }
    
    
}
