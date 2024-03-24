//
//  HomeViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/8/24.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recipeCollectionView: UICollectionView!
    @IBOutlet weak var newRecipeCollectionView: UICollectionView!
    @IBOutlet weak var nameActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var newRecipeNewActivity: UIActivityIndicatorView!
    
    
    let homeViewModel = HomeViewModel()
    let filterViewController = FilterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpUI()
        fetchUserName()
        fetchRecipes()
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
        }
        
        
    }
    @IBAction func filterBtnPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
            newViewController.filterDelegate = self
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    func setUpUI() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.newRecipeNewActivity.startAnimating()
            self.nameActivityIndicator.startAnimating()
            self.searchBar.delegate = self
            self.filterViewController.filterDelegate?.filterButtonPressed()
            //data sources
            self.recipeCollectionView.dataSource = self
            self.recipeCollectionView.delegate = self
            self.recipeCollectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            
            self.newRecipeCollectionView.dataSource = self
            self.newRecipeCollectionView.delegate = self
            self.newRecipeCollectionView.register(UINib(nibName: "NewRecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCell")
            
            self.categoryCollectionView.dataSource = self
            self.categoryCollectionView.delegate = self
            self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        }
    }
    
    func fetchUserName() {
        //code to fetch username
        homeViewModel.fetchName { [weak self] userName in
            if let userName = userName {
                DispatchQueue.main.async {
                    self?.userName.text = "Hello, \(userName)"
                    self?.nameActivityIndicator.stopAnimating()
                    self?.nameActivityIndicator.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self?.userName.text = "Hello"
                    self?.nameActivityIndicator.stopAnimating()
                    self?.nameActivityIndicator.isHidden = true
                }
            }
        }
    }
    
    func fetchRecipes() {
        //code to fetch recipes:
        homeViewModel.loadRecipes { [weak self] recipes, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error loading recipes: \(error)")
                return
            }
            
            if let recipes = recipes {
                Recipe.all = recipes
                self.homeViewModel.originFilteredRecipes = recipes
                self.homeViewModel.filteredRecipes = recipes
                self.homeViewModel.recipesLoaded = true
                guard self.homeViewModel.recipesLoaded else { return }
                DispatchQueue.main.async {
                    
                    self.recipeCollectionView.reloadData()
                    self.newRecipeCollectionView.reloadData()
                    self.categoryCollectionView.reloadData()
                    
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.newRecipeNewActivity.stopAnimating()
                    self.newRecipeNewActivity.isHidden = true
                }
            }
        }
    }

    
}
