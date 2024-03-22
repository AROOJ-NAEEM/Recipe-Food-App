//
//  HomeViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import Foundation
import FirebaseAuth

class HomeViewModel {
    static let shared = HomeViewModel()
    private let dbManager = DatabaseManager.shared
    var origin = ["All", "Indian", "Italian", "Asian" ,"Chinese"]
    var recipesLoaded = false
    var filteredRecipes: [Recipe] = []
    var originFilteredRecipes: [Recipe] = []
    var filter: FilterModel?
    var timeFilter: String?
    var rateFilter: String?
    var categoryFilter: String?

    init() {
        self.filter = FilterManager.shared.filter
        self.timeFilter = filter?.time
        self.rateFilter = filter?.rate
        self.categoryFilter = filter?.category
    }
    
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
    
    func filterNewRecipes() -> [Recipe] {
            let currentDate = Date()
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
            filteredRecipes = Recipe.all.filter { recipe in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let publishedDate = dateFormatter.date(from: recipe.publishedDate) else {
                    return false
                }
                return publishedDate >= twoMonthsAgo
            }
            return filteredRecipes
        }
    
    func filterRecipesWithOrigin(withOrigin origin: String) {
        if origin == "All" {
            originFilteredRecipes = Recipe.all
        } else {
            originFilteredRecipes = Recipe.all.filter { $0.origin == origin }
        }
    }
    
    func categoryFilterRecipes() {
        if categoryFilter == "All" {
            originFilteredRecipes = Recipe.all
        } else {
            originFilteredRecipes = Recipe.all.filter { $0.category == categoryFilter }
        }
    }
    
    func timeFilterRecipes() {
        if timeFilter == "Newest" {
            let currentDate = Date()
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
            originFilteredRecipes = originFilteredRecipes.filter { recipe in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let publishedDate = dateFormatter.date(from: recipe.publishedDate) else {
                    return false
                }
                return publishedDate >= twoMonthsAgo
            }
        } else if timeFilter == "Oldest" {
            let currentDate = Date()
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
            originFilteredRecipes = originFilteredRecipes.filter { recipe in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let publishedDate = dateFormatter.date(from: recipe.publishedDate) else {
                    return false
                }
                return publishedDate < twoMonthsAgo
            }
        } else if timeFilter == "All" {
            originFilteredRecipes = Recipe.all
        }
    }
    
    func rateFilterRecipe() {
        if let firstDigit = rateFilter?.first, let rateInt = Int(String(firstDigit)) {
            originFilteredRecipes = originFilteredRecipes.filter { $0.rating == rateInt }
        }
    }
    
    func updatefilterManager() {
        FilterManager.shared.filter.time = ""
        FilterManager.shared.filter.rate = ""
        FilterManager.shared.filter.category = ""
    }
    
    
}
