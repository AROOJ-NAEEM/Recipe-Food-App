//
//  FilterModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/18/24.
//

import Foundation

struct FilterModel {
    var time: String
    var rate: String
    var category: String
    
    init(time: String, rate: String, category: String) {
        self.time = time
        self.rate = rate
        self.category = category
    }
}
