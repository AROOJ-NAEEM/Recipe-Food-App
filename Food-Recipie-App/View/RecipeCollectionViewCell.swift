//
//  RecipeCollectionViewCell.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/12/24.
//

import UIKit
import RealmSwift
import FirebaseFirestore
import SwiftUI

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rateView: UIView!
    let realm = try! Realm()
    var recipe: [Recipes] = []
    var ingredient: [Ingredient] = []
    var procedures: [Procedure] = []
    
    var creator: String = ""
    var publishedDate: String = ""
    var ingredients: [String: [String: String]] = [:]
    var category = ""
    var procedure: [[String: Any]] = []
    var rating: Int = 0
    var origin = ""
    var creatorImage: String = ""
    var recipeImage1: String = ""
    var status: Bool = false

    weak var delegate: RecipeCellDelegate?
    weak var reloadDelegate: SavedRecipeDelegate?
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var recipeCard: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var timeToCook: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recipeImage.layer.cornerRadius = recipeImage.frame.size.width / 2
        recipeImage.clipsToBounds = true
        recipeCard.layer.cornerRadius = recipeCard.frame.size.height / 10
        rateView.layer.cornerRadius = rateView.frame.size.height / 2
        rateView.layer.masksToBounds = true
    }
    func updateStatus(_ status: Bool) {
        self.status = status
        if status {
            saveBtn.isEnabled = false
//            saveBtn.setImage(UIImage(named: "checkmark"), for: .normal)
//            saveBtn.backgroundColor = UIColor(named: "buttonColor")
        } else {
            saveBtn.isEnabled = true
        }
    }
    @IBAction func saveRecipePressed(_ sender: UIButton) {
        let newRecipe = Recipes()
        let newIngredient = Ingredient()
        let newProcedure = Procedure()
        newRecipe.name = recipeName.text ?? ""
        newRecipe.image = recipeImage1
        newRecipe.requiredTime = timeToCook.text ?? ""
        newRecipe.creator = creator
        newRecipe.publishedDate = publishedDate
        newRecipe.category = category
        newRecipe.rating = rating
        newRecipe.origin = origin
        newRecipe.creatorImage = creatorImage
        
        for (ingredientName, _) in ingredients {
            let newIngredient = Ingredient()
            newIngredient.name = ingredientName
            
            if let ingredientData = ingredients[ingredientName] {
                for (ingredientImage, ingredientQuantity) in ingredientData {
                    newIngredient.image = ingredientImage
                    newIngredient.quantity = ingredientQuantity
                }
            }
            ingredient.append(newIngredient)
        }
        newRecipe.ingredients.append(objectsIn: ingredient)

        for stepDict in procedure {
            let newProcedure = Procedure()
            if let stepDetail = stepDict["stepDetail"] as? String,
               let stepNumber = stepDict["stepNumber"] as? Int {
                newProcedure.stepDetail = stepDetail
                newProcedure.stepNumber = stepNumber
                newRecipe.procedure.append(newProcedure)
            }
        }
        
        recipe.append(newRecipe)
        ingredient.append(newIngredient)
        procedures.append(newProcedure)
        
        
        saveRecipes(recipe: newRecipe)
        
        let recipeName = recipeName.text ?? ""
        let db = Firestore.firestore()

        db.collection("recipes")
            .whereField("name", isEqualTo: recipeName)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else {
                        print("No documents found")
                        return
                    }
                    if let document = documents.first {
                        let recipeID = document.documentID
                        let recipeRef = db.collection("recipes").document(recipeID)
                        recipeRef.updateData(["status": true]) { error in
                            if let error = error {
                                print("Error updating document: \(error)")
                            } else {
                                print("Document successfully updated")
                                self.saveBtn.isEnabled = false
                            }
                        }
                    } else {
                        print("Recipe with name '\(recipeName)' not found")
                    }
                }
            }
        delegate?.didPressSaveButton(in: self)
//        sender.isEnabled = false
//        sender.setImage(UIImage(named: "checkmark"), for: .normal)
//        sender.backgroundColor = UIColor(named: "buttonColor")
    }
    
    func saveRecipes(recipe: Recipes) {
        do {
            try realm.write {
                realm.add(recipe)
//                realm.add(ingredient)
//                realm.add(procedure)
                reloadDelegate?.recipesDidChange()
            }
        } catch {
            print("Error saving recipe, \(error)")
        }
    }
}
