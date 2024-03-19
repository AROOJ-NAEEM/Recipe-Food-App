//
//  RecipeDetailExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/15/24.
//

import Foundation
import UIKit

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ingredientTableView {
            return recipeDetailViewModel.ingredient?.count ?? 0
        }
        else {
            return recipeDetailViewModel.procedure?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ingredientTableView {
            let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IngredientTableViewCell
            if let ingredient = recipeDetailViewModel.ingredient {
                let ingredientKeys = Array(ingredient.keys)
                    let ingredientValues = Array(ingredient.values)

                    if indexPath.row < ingredientKeys.count {
                        let ingredientName = ingredientKeys[indexPath.row]
                        let ingredientDetail = ingredientValues[indexPath.row]
                        if let imageURL = URL(string: ingredientDetail.keys.first!), let weight = ingredientDetail.values.first {
                            cell.ingredentWeight.text = weight
                            cell.ingredientImage.load(url: imageURL)
                        } else {
                            print("Invalid image URL")
                        }
                        cell.ingredientName.text = ingredientName
                    }
            }

            return cell
        }
        else {
            let cell = procedureTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProcedureTableViewCell
            if let procedure = recipeDetailViewModel.procedure {
                let sortedProcedure = procedure.sorted { (step1, step2) in
                    guard let stepNumber1 = step1["stepNumber"] as? Int, let stepNumber2 = step2["stepNumber"] as? Int else {
                        return false
                    }
                    return stepNumber1 < stepNumber2
                }
                if indexPath.row < sortedProcedure.count {
                    let step = sortedProcedure[indexPath.row]
                    if let stepNumber = step["stepNumber"] as? Int, let stepDetail = step["stepDetail"] as? String {
                       cell.stepNumber.text = "Step \(stepNumber)"
                        cell.stepDetail.text = stepDetail
                    }
                }
            }
            return cell
        }
    }
    
    
    
}
