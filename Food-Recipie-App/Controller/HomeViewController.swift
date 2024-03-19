//
//  HomeViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/8/24.
//

import UIKit
class HomeViewController: UIViewController {

    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var newRecipeCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    let homeViewModel = HomeViewModel()
    let filterViewController = FilterViewController()
    var origin = ["All", "Indian", "Italian", "Asian" ,"Chinese"]
    var recipesLoaded = false
    var filteredRecipes: [Recipe] = []
    var originFilteredRecipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.delegate = self
        filterViewController.filterDelegate?.filterButtonPressed()
        //data sources
        recipeCollectionView.dataSource = self
        recipeCollectionView.delegate = self
        recipeCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        newRecipeCollectionView.dataSource = self
        newRecipeCollectionView.delegate = self
        newRecipeCollectionView.register(UINib(nibName: "NewRecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        //code to fetch username
        homeViewModel.fetchName { [weak self] userName in
            if let userName = userName {
                DispatchQueue.main.async {
                    self?.userName.text = "Hello, \(userName)"
                }
            } else {
                print("user is not signed in or data not found")
            }
        }
        
        //code to fetch recipes:
        homeViewModel.loadRecipes { [weak self] recipes, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            
            if let recipes = recipes {
                Recipe.all = recipes
                self.originFilteredRecipes = recipes
                //print("all recipes= \(Recipe.all)")
                self.recipesLoaded = true
                guard self.recipesLoaded else { return }
                DispatchQueue.main.async {
                    self.recipeCollectionView.reloadData()
                    self.newRecipeCollectionView.reloadData()
                    self.categoryCollectionView.reloadData()
                }
            }
        }
        
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
        
        
    }
    @IBAction func filterBtnPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        newViewController.filterDelegate = self
        present(newViewController, animated: true, completion: nil)
    }

    
}
