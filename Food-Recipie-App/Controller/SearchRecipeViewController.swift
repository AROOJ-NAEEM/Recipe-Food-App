//
//  SearchRecipeViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import UIKit

class SearchRecipeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recipeCount: UILabel!
    @IBOutlet weak var searchRecipeCollectionView: UICollectionView!
    
    var filterRecipes = Recipe.all
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        // Do any additional setup after loading the view.
        searchRecipeCollectionView.dataSource = self
        searchRecipeCollectionView.delegate = self
        searchRecipeCollectionView.register(UINib(nibName: "SearchRecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        recipeCount.text = ("\(Recipe.all.count) results")
        

    }
    override func viewDidAppear(_ animated: Bool) {
        searchBar.becomeFirstResponder()
    }
}
