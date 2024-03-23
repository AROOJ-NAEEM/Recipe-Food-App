//
//  RecipeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/12/24.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    //weak var delegate: RecipeCellDelegate?
    //weak var saveButtonDelegate: RecipeSaveButtonDelegate?
   // weak var reloadDelegate: SavedRecipeDelegate?
    private var viewModel: RecipeCollectionViewCellViewModel?
    
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet private weak var recipeCard: UIView!
    @IBOutlet private weak var recipeImage: UIImageView!
    @IBOutlet private weak var recipeName: UILabel!
    @IBOutlet private weak var timeToCook: UILabel!
    @IBOutlet private weak var recipeRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recipeImage.layer.cornerRadius = recipeImage.frame.size.width / 2
        recipeImage.clipsToBounds = true
        recipeCard.layer.cornerRadius = recipeCard.frame.size.height / 10
        rateView.layer.cornerRadius = rateView.frame.size.height / 2
        rateView.layer.masksToBounds = true
        
        viewModel = RecipeCollectionViewCellViewModel()
    }
    func updateStatus(_ status: Bool) {
        self.viewModel?.status = status
        if status {
            saveBtn.isEnabled = false
        } else {
            saveBtn.isEnabled = true
        }
    }
    @IBAction func saveRecipePressed(_ sender: UIButton) {
        
        if let viewModel = viewModel {
            let newRecipe = Recipes()
            let newIngredient = Ingredient()
            let newProcedure = Procedure()
            newRecipe.name = recipeName.text ?? ""
            newRecipe.image = viewModel.recipeImage
            newRecipe.requiredTime = timeToCook.text ?? ""
            newRecipe.creator = viewModel.creator
            newRecipe.publishedDate = viewModel.publishedDate
            newRecipe.category = viewModel.category
            newRecipe.rating = viewModel.rating
            newRecipe.origin = viewModel.origin
            newRecipe.creatorImage = viewModel.creatorImage
            for (ingredientName, _) in viewModel.ingredients {
                let newIngredient = Ingredient()
                newIngredient.name = ingredientName

                if let ingredientData = viewModel.ingredients[ingredientName] {
                    for (ingredientImage, ingredientQuantity) in ingredientData {
                        newIngredient.image = ingredientImage
                        newIngredient.quantity = ingredientQuantity
                    }
                }
                viewModel.ingredient.append(newIngredient)
            }
            newRecipe.ingredients.append(objectsIn: viewModel.ingredient)

            for stepDict in viewModel.procedure {
                let newProcedure = Procedure()
                if let stepDetail = stepDict["stepDetail"] as? String,
                   let stepNumber = stepDict["stepNumber"] as? Int {
                    newProcedure.stepDetail = stepDetail
                    newProcedure.stepNumber = stepNumber
                    newRecipe.procedure.append(newProcedure)
                }
            }
        

            viewModel.recipe.append(newRecipe)
            viewModel.ingredient.append(newIngredient)
            viewModel.procedures.append(newProcedure)
            
            
            viewModel.saveRecipes(recipe: newRecipe)
            //reloadDelegate?.recipesDidChange()
            
            let recipeName = recipeName.text ?? ""
            viewModel.updateRecipeStatus(withName: recipeName)
        }
        
        
        updateStatus(true)
        
        //delegate?.didPressSaveButton(in: self)
        //reloadDelegate?.recipesDidChange()
    }
    
    func configure(with recipe: Recipe) {
        viewModel?.recipeImage = recipe.image
        viewModel?.creator = recipe.creator
        viewModel?.publishedDate = recipe.publishedDate
        viewModel?.category = recipe.category
        viewModel?.procedure = recipe.procedure
        viewModel?.rating = recipe.rating
        viewModel?.origin = recipe.origin
        viewModel?.creatorImage = recipe.creatorImage
        viewModel?.ingredients = recipe.ingredients
        viewModel?.status = recipe.status
        updateStatus(recipe.status)
        recipeRating.text = "\(recipe.rating)"
        if let imageUrl = URL(string: recipe.image) {
            recipeImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Recipe's Image"))
            } else {
                print("Invalid image URL")
            }
        recipeName.text = recipe.name
        timeToCook.text = recipe.requiredTime
    }
}
