//
//  RateCollectionViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation

class RateCollectionViewModel {
    func setCategoryLabelValue(category: String) {
        FilterManager.shared.filter.category = category
    }
}
