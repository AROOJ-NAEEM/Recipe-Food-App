//
//  SavedRecipeExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import Foundation
import UIKit

extension SavedRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedRecipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SavedRecipeCollectionViewCell
        if let recipe = recipes?[indexPath.row] {
            cell.configure(with: recipe)
        }
        return cell
    }
    
    
}

extension SavedRecipeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let recipeDetailViewModel = RecipeDetailViewModel()
       if let savedRecipe = recipes?[indexPath.row] {
           let recipeData = viewModel.convertRecipe(recipe: savedRecipe)
           if let recipe = Recipe(data: recipeData) {
               recipeDetailViewModel.configure(with: recipe)
               performSegue(withIdentifier: "ViewRecipeDetails", sender: recipeDetailViewModel)
           } else {
               print("Failed to create Recipe object from data.")
           }
       }
   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewRecipeDetails" {
            if let newViewController = segue.destination as? RecipeDetailViewController {
                if let recipeDetailViewModel = sender as? RecipeDetailViewModel {
                    newViewController.recipeDetailViewModel = recipeDetailViewModel
                }
            }
        }
    }
}

extension SavedRecipeViewController: SavedRecipeDelegate {
    func recipesDidChange() {
        DispatchQueue.main.async {
            self.savedRecipeCollectionView.reloadData()
        }
    }
}
