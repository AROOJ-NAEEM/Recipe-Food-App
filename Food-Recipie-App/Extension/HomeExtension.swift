//
//  HomeViewControllerExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recipeCollectionView {
            return originFilteredRecipes.count
        } else if collectionView == categoryCollectionView {
            print(origin.count)
            return origin.count
        } else if collectionView == newRecipeCollectionView {
            let currentDate = Date()
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
            filteredRecipes = Recipe.all.filter { recipe in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let publishedDate = dateFormatter.date(from: recipe.publishedDate) else {
                    return false
                }
                return publishedDate >= twoMonthsAgo
            }
            return filteredRecipes.count
        }
        return Recipe.all.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.recipeCollectionView) {
            let cell = recipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecipeCollectionViewCell
            cell.recipeImage1 = originFilteredRecipes[indexPath.row].image
            cell.creator = originFilteredRecipes[indexPath.row].creator
            cell.publishedDate = originFilteredRecipes[indexPath.row].publishedDate
            cell.category = originFilteredRecipes[indexPath.row].category
            cell.procedure = originFilteredRecipes[indexPath.row].procedure
            cell.rating = originFilteredRecipes[indexPath.row].rating
            cell.origin = originFilteredRecipes[indexPath.row].origin
            cell.creatorImage = originFilteredRecipes[indexPath.row].creatorImage
            cell.ingredients = originFilteredRecipes[indexPath.row].ingredients
            cell.status = originFilteredRecipes[indexPath.row].status
            cell.updateStatus(originFilteredRecipes[indexPath.row].status)
            cell.recipeRating.text = "\(originFilteredRecipes[indexPath.row].rating)"
            if let imageUrl = URL(string: originFilteredRecipes[indexPath.row].image) {
                print("Loading image from \(imageUrl)")
                cell.recipeImage.load(url: imageUrl)
            } else {
                print("Invalid image URL")
            }
            cell.recipeName.text = originFilteredRecipes[indexPath.row].name
            cell.timeToCook.text = originFilteredRecipes[indexPath.row].requiredTime
            //cell.filterDelegate = self
            return cell
        }

        
        
        
        else if (collectionView == self.newRecipeCollectionView) {
            print("2nd collection view")
            let cell2 = newRecipeCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewRecipeCollectionViewCell
            if let imageUrl = URL(string: filteredRecipes[indexPath.row].image), let creatorImageUrl =  URL(string: filteredRecipes[indexPath.row].creatorImage) {
                print("Loading image from \(imageUrl)")
                cell2.recipeImage.load(url: imageUrl)
                cell2.creatorImage.load(url: creatorImageUrl)
            } else {
                print("Invalid image URL")
            }
            cell2.recipeName.text = filteredRecipes[indexPath.row].name
            cell2.timeToCook.text = "⏱ \(filteredRecipes[indexPath.row].requiredTime)"
            cell2.creatorName.text = "By \(filteredRecipes[indexPath.row].creator)"
            cell2.cofigureRating(noOfStar: filteredRecipes[indexPath.row].rating)
            return cell2
        }
        
        
        
        else {
            let cell3 = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
            print("IndexPath: \(indexPath), Origin Count: \(origin.count)")
            cell3.categoryButton.setTitle(origin[indexPath.row], for: .normal)
            cell3.delegate = self
            return cell3
        }
        
    }

    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recipeCollectionView {
            //performSegue(withIdentifier: "ViewRecipeDetails", sender: self)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
            let recipeDetailViewModel = RecipeDetailViewModel()
            recipeDetailViewModel.name = originFilteredRecipes[indexPath.row].name
            if let imageUrl = URL(string: originFilteredRecipes[indexPath.row].image) {
                print("Loading image from \(imageUrl)")
                recipeDetailViewModel.img = imageUrl
            } else {
                print("Invalid image URL")
            }
            recipeDetailViewModel.time = originFilteredRecipes[indexPath.row].requiredTime
            recipeDetailViewModel.count = originFilteredRecipes[indexPath.row].ingredients.count
            recipeDetailViewModel.ingredient = originFilteredRecipes[indexPath.row].ingredients
            recipeDetailViewModel.procedure = originFilteredRecipes[indexPath.row].procedure
            //recipeDetailViewModel.recipeRating = originFilteredRecipes[indexPath.row].rating
            newViewController.recipeDetailViewModel = recipeDetailViewModel
            let navigationController = UINavigationController(rootViewController: newViewController)
            newViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissViewController))
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
        else if collectionView == newRecipeCollectionView {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
            let recipeDetailViewModel = RecipeDetailViewModel()
                recipeDetailViewModel.name = filteredRecipes[indexPath.row].name
                if let imageUrl = URL(string: filteredRecipes[indexPath.row].image) {
                    print("Loading image from \(imageUrl)")
                    recipeDetailViewModel.img = imageUrl
                } else {
                    print("Invalid image URL")
                }
            recipeDetailViewModel.time = filteredRecipes[indexPath.row].requiredTime
            recipeDetailViewModel.count = filteredRecipes[indexPath.row].ingredients.count
            recipeDetailViewModel.ingredient = filteredRecipes[indexPath.row].ingredients
            recipeDetailViewModel.procedure = filteredRecipes[indexPath.row].procedure
            newViewController.recipeDetailViewModel = recipeDetailViewModel
            let navigationController = UINavigationController(rootViewController: newViewController)
            newViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissViewController))
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
        
        else if collectionView == categoryCollectionView {
            print(indexPath.row)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
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
        if origin == "All" {
            originFilteredRecipes = Recipe.all
        } else {
            originFilteredRecipes = Recipe.all.filter { $0.origin == origin }
        }
        recipeCollectionView.reloadData()
    }
}

extension HomeViewController: FilterButtonDelegate {
    func filterButtonPressed() {
        let filter = FilterManager.shared.filter
        let timeFilter = filter.time
        let rateFilter = filter.rate
        let categoryFilter = filter.category
        if categoryFilter == "All" {
            originFilteredRecipes = Recipe.all
        } else {
            originFilteredRecipes = Recipe.all.filter { $0.category == categoryFilter }
        }
        
        if timeFilter == "Newest" {
            let currentDate = Date()
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
            originFilteredRecipes = originFilteredRecipes.filter { recipe in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let publishedDate = dateFormatter.date(from: recipe.publishedDate) else {
                    return false
                }
                return publishedDate >= twoMonthsAgo
            }
        } else if timeFilter == "Oldest" {
            let currentDate = Date()
            let twoMonthsAgo = Calendar.current.date(byAdding: .month, value: -2, to: currentDate)!
            originFilteredRecipes = originFilteredRecipes.filter { recipe in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let publishedDate = dateFormatter.date(from: recipe.publishedDate) else {
                    return false
                }
                return publishedDate < twoMonthsAgo
            }
        } else if timeFilter == "All" {
            originFilteredRecipes = Recipe.all
        }
        
        if let firstDigit = rateFilter.first, let rateInt = Int(String(firstDigit)) {
            originFilteredRecipes = originFilteredRecipes.filter { $0.rating == rateInt }
        }
        
        recipeCollectionView.reloadData()
        
        FilterManager.shared.filter.time = ""
        FilterManager.shared.filter.rate = ""
        FilterManager.shared.filter.category = ""
    }
}

extension HomeViewController: RecipeCellDelegate {
    func didPressSaveButton(in cell: RecipeCollectionViewCell) {
        recipeCollectionView.reloadData()
        newRecipeCollectionView.reloadData()
        guard let parentCell = cell.superview?.superview as? RecipeCollectionViewCell else {
                return
            }
        if Recipe.all.contains(where: { $0.status }) {
            parentCell.saveBtn.isEnabled = false
        } else {
            parentCell.saveBtn.isEnabled = true
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received for image")
                return
            }
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            } else {
                print("Invalid image data")
            }
        }
        task.resume()
    }
}

