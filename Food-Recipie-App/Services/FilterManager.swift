//
//  FilterManager.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import Foundation

class FilterManager {
    static let shared = FilterManager()
    var filter: FilterModel
    
    private init() {
        filter = FilterModel(time: "", rate: "", category: "")
    }
}
