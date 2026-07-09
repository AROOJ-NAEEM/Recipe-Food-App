//
//  FilterCategoryViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/22/24.
//

import Foundation

class FilterCategoryCollectionViewModel {
    func storeCategoryLabelVlaue(categoryLabel: String) {
        FilterManager.shared.filter.category = categoryLabel
    }
}
