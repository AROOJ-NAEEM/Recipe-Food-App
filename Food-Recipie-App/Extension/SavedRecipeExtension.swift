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
        return recipes?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = savedRecipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SavedRecipeCollectionViewCell
        if let imageUrl = URL(string: recipes?[indexPath.row].image ?? "") {
            print("Loading image from \(imageUrl)")
            //cell.recipeImage.load(url: imageUrl)
            cell.recipeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Recipe's Image"))
    
        } else {
            print("Invalid image URL")
        }
        cell.recipeName.text = recipes?[indexPath.row].name
        cell.creatorName.text = "By \(recipes?[indexPath.row].creator ?? "")"
        cell.timeToCook.text = "⏱ \(recipes?[indexPath.row].requiredTime ?? "")"
        cell.recipeRating.text = "\(recipes?[indexPath.row].rating ?? 0)"
        return cell
    }
    
    
}

extension SavedRecipeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeDetailViewModel = RecipeDetailViewModel()
        recipeDetailViewModel.name = recipes?[indexPath.row].name ?? ""
        if let imageUrl = URL(string: recipes?[indexPath.row].image ?? "") {
                print("Loading image from \(imageUrl)")
                recipeDetailViewModel.img = imageUrl
            } else {
                print("Invalid image URL")
            }
        recipeDetailViewModel.time = recipes?[indexPath.row].requiredTime ?? ""
        recipeDetailViewModel.count = recipes?[indexPath.row].ingredients.count ?? 0
        
        var ingredientsDict: [String: [String: String]] = [:]
        if let ingredients = recipes?[indexPath.row].ingredients {
            for ingredient in ingredients {
                var ingredientInfo: [String: String] = [:]
                ingredientInfo[ingredient.image] = ingredient.quantity
                ingredientsDict[ingredient.name] = ingredientInfo
            }
        }
        recipeDetailViewModel.ingredient = ingredientsDict
        var procedureArray: [[String: Any]] = []
        if let procedureList = recipes?[indexPath.row].procedure {
            for procedure in procedureList {
                let procedureDict: [String: Any] = [
                    "stepNumber": procedure.stepNumber,
                    "stepDetail": procedure.stepDetail
                ]
                procedureArray.append(procedureDict)
            }
        }
        recipeDetailViewModel.procedure = procedureArray
        performSegue(withIdentifier: "ViewRecipeDetails", sender: recipeDetailViewModel)
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
