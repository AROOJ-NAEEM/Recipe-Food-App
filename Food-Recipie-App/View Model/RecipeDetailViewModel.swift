//
//  RecipeDetailViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import Foundation

class RecipeDetailViewModel {
    var img: URL?
    var name = ""
    var time = ""
    var count = 0
    var ingredient: [String: [String: String]]?
    var procedure: [[String: Any]]?
}
