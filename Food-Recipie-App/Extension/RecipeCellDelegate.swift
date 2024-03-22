//
//  RecipeCellDelegate.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/17/24.
//

import Foundation

protocol RecipeCellDelegate: AnyObject {
    func didPressSaveButton(in cell: RecipeCollectionViewCell)
}

protocol CategoryCellDelegate: AnyObject {
    func categoryButtonPressed(withOrigin origin: String)
}

protocol FilterButtonDelegate: AnyObject {
    func filterButtonPressed()
}

protocol SavedRecipeDelegate: AnyObject {
    func recipesDidChange()
}
protocol RecipeSaveButtonDelegate: AnyObject {
    func didPressSaveButton()
}
