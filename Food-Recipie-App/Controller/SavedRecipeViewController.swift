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
    let homeViewModel = HomeViewModel()
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
        
        
        fetchRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRecipes()
    }
    
    func fetchRecipes() {
        recipes = realm.objects(Recipes.self)
        savedRecipeCollectionView.reloadData()
    }

}
