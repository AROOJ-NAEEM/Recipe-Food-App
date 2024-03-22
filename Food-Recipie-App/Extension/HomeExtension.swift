//
//  HomeViewControllerExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case recipeCollectionView:
            return homeViewModel.originFilteredRecipes.count
        case newRecipeCollectionView:
            let newRecipes = homeViewModel.filterNewRecipes()
            return newRecipes.count
        case categoryCollectionView:
            return homeViewModel.origin.count
        default:
            return Recipe.all.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.recipeCollectionView) {
            let cell = recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCollectionViewCell
            let recipe = homeViewModel.originFilteredRecipes[indexPath.row]
            cell.delegate = self
            //cell.saveButtonDelegate = self 
            cell.configure(with: recipe)
            return cell
        }

        else if (collectionView == self.newRecipeCollectionView) {
            let cell2 = newRecipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewRecipeCollectionViewCell
            let recipe = homeViewModel.filteredRecipes[indexPath.row]
            cell2.cofigure(with: recipe)
            return cell2
        }
        
        else {
            let cell3 = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
            print("IndexPath: \(indexPath), Origin Count: \(homeViewModel.origin.count)")
            let origin = homeViewModel.origin[indexPath.row]
            cell3.configure(with: origin)
            cell3.delegate = self
            return cell3
        }
        
    }

    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recipeCollectionView {
            let recipeDetailViewModel = RecipeDetailViewModel()
            let recipe = homeViewModel.originFilteredRecipes[indexPath.row]
            recipeDetailViewModel.configure(with: recipe)
            performSegue(withIdentifier: "ViewRecipeDetails", sender: recipeDetailViewModel)
        }
        else if collectionView == newRecipeCollectionView {
            let recipeDetailViewModel = RecipeDetailViewModel()
            let recipe = homeViewModel.filteredRecipes[indexPath.row]
            recipeDetailViewModel.configure(with: recipe)
            performSegue(withIdentifier: "ViewRecipeDetails", sender: recipeDetailViewModel)
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 50
        let height: CGFloat = 231
        return CGSize(width: width, height: height)
    }
}


extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: "SearchBar", sender: self)
        searchBar.resignFirstResponder()
    }
}

extension HomeViewController: CategoryCellDelegate {
    func categoryButtonPressed(withOrigin origin: String) {
        homeViewModel.filterRecipesWithOrigin(withOrigin: origin)
        recipeCollectionView.reloadData()
    }
}

extension HomeViewController: FilterButtonDelegate {
    func filterButtonPressed() {
        homeViewModel.filter = FilterManager.shared.filter
        homeViewModel.timeFilter = homeViewModel.filter?.time
        homeViewModel.rateFilter = homeViewModel.filter?.rate
        homeViewModel.categoryFilter = homeViewModel.filter?.category

        homeViewModel.categoryFilterRecipes()
        homeViewModel.timeFilterRecipes()
        homeViewModel.rateFilterRecipe()
        
        recipeCollectionView.reloadData()
        
        homeViewModel.updatefilterManager()
    }
}

extension HomeViewController: RecipeCellDelegate {
    func didPressSaveButton(in cell: RecipeCollectionViewCell) {
        //guard let parentCell = cell.superview?.superview as? RecipeCollectionViewCell else {
//                return
//            }
 //   let allRecipes = homeViewModel.originFilteredRecipes
//        print(" Value  == \(allRecipes.contains(where: { $0.status }))")
//        if allRecipes.contains(where: { $0.status }) {
//            cell.saveBtn.isEnabled = false
//        } else {
//            cell.saveBtn.isEnabled = true
//        }
        DispatchQueue.main.async {
            self.recipeCollectionView.reloadData()
        }
   }
}
extension HomeViewController: RecipeSaveButtonDelegate {
    func didPressSaveButton() {
        recipeCollectionView.reloadData()
    }
}

