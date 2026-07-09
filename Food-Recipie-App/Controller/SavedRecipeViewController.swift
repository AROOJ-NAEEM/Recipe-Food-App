//
//  SavedRecipeViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import UIKit
import RealmSwift

class SavedRecipeViewController: UIViewController {
    
    let viewModel = SavedRecipeViewModel()
    let recipeManager = RecipeCollectionViewCell()
    var recipes: Results<Recipes>?
    
    
    @IBOutlet weak var savedRecipeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchRecipes()
        savedRecipeCollectionView.reloadData()
    }
    
    func setupUI() {
        savedRecipeCollectionView.dataSource = self
        savedRecipeCollectionView.delegate = self
        savedRecipeCollectionView.register(UINib(nibName: "SavedRecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    func fetchRecipes() {
        viewModel.fetchRecipes { recipe, error in
            self.recipes = recipe
        }
        savedRecipeCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipes()
        savedRecipeCollectionView.reloadData()
    }

}
