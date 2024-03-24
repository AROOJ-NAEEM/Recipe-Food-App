//
//  RecipeDetailViewController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/13/24.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var timeToCook: UILabel!
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var procedureTableView: UITableView!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    var recipeDetailViewModel = RecipeDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        if let img = recipeDetailViewModel.img {
            recipeImg.sd_setImage(with: img, placeholderImage: UIImage(named: "Recipe's Image"))
        }
        recipeName.text = recipeDetailViewModel.name
        timeToCook.text = "⏱ \(recipeDetailViewModel.time)"
        itemCount.text = "\(recipeDetailViewModel.count) Items"
    }
    
    func setupTableView() {
        ingredientTableView.dataSource = self
        ingredientTableView.register(UINib(nibName: "IngredientTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        procedureTableView.dataSource = self
        procedureTableView.register(UINib(nibName: "ProcedureTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
    @IBAction func ingredientBtnPressed(_ sender: Any) {
        ingredientTableView.isHidden = false
        procedureTableView.isHidden = true
    }
    
    @IBAction func procedureBtnPressed(_ sender: Any) {
        procedureTableView.isHidden = false
        ingredientTableView.isHidden = true
    }
    
    @IBAction func shareRecipeBtn(_ sender: UIButton) {
        let recipe = recipeName.text
        if let img = recipeDetailViewModel.img {
            recipeImg.sd_setImage(with: img, placeholderImage: UIImage(named: "Recipe's Image"))
        }
        let image: UIImageView = recipeImg
        
        let vc = UIActivityViewController(activityItems: [recipe ?? "recipe' name", image ], applicationActivities: [])
        
        if let popoverController = vc.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        self.present(vc, animated: true, completion: nil)
    }
}


