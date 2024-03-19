//
//  SearchRecipeExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import Foundation
import UIKit


extension SearchRecipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchRecipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchRecipeCollectionViewCell
        if let imageUrl = URL(string: filterRecipes[indexPath.row].image) {
            print("Loading image from \(imageUrl)")
            cell.recipeImage.load(url: imageUrl)
        } else {
            print("Invalid image URL")
        }
        cell.recipeName.text = filterRecipes[indexPath.row].name
        cell.creatorName.text = ("By \(filterRecipes[indexPath.row].creator)")
        cell.recipeRating.text = "\(filterRecipes[indexPath.row].rating)"
        return cell
    }
    
    
}

extension SearchRecipeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filterRecipes = Recipe.all
       } else {
           filterRecipes = Recipe.all.filter { $0.name.lowercased().contains(searchText.lowercased()) }
       }
       recipeCount.text = "\(filterRecipes.count) results"
       searchRecipeCollectionView.reloadData()
    }
}

extension SearchRecipeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        let recipeDetailViewModel = RecipeDetailViewModel()
        recipeDetailViewModel.name = Recipe.all[indexPath.row].name
        if let imageUrl = URL(string: Recipe.all[indexPath.row].image) {
            print("Loading image from \(imageUrl)")
            recipeDetailViewModel.img = imageUrl
        } else {
            print("Invalid image URL")
        }
        recipeDetailViewModel.time = Recipe.all[indexPath.row].requiredTime
        recipeDetailViewModel.count = Recipe.all[indexPath.row].ingredients.count
        recipeDetailViewModel.ingredient = Recipe.all[indexPath.row].ingredients
        recipeDetailViewModel.procedure = Recipe.all[indexPath.row].procedure
        newViewController.recipeDetailViewModel = recipeDetailViewModel
        let navigationController = UINavigationController(rootViewController: newViewController)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window!.rootViewController = navigationController
    }
}
