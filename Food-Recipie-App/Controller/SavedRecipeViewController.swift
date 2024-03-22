//
//  SavedRecipeViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/11/24.
//

import UIKit
import RealmSwift

class SavedRecipeViewController: UIViewController {

    let realm = try! Realm()
    let viewModel = SavedRecipeViewModel()
    let recipeManager = RecipeCollectionViewCell()
    var recipes: Results<Recipes>?
    
    
    @IBOutlet weak var savedRecipeCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeManager.reloadDelegate = self
        savedRecipeCollectionView.dataSource = self
        savedRecipeCollectionView.delegate = self
        savedRecipeCollectionView.register(UINib(nibName: "SavedRecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
        
        
        viewModel.fetchRecipes { recipe, error in
            self.recipes = recipe
        }
        savedRecipeCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchRecipes { recipe, error in
            self.recipes = recipe
        }
        savedRecipeCollectionView.reloadData()
    }

}
