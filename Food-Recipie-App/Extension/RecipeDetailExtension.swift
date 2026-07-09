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
        switch tableView {
        case ingredientTableView :
            return recipeDetailViewModel.ingredient?.count ?? 0
        case procedureTableView :
            return recipeDetailViewModel.procedure?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case ingredientTableView :
            let cell = ingredientTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IngredientTableViewCell
            cell.configure(with: recipeDetailViewModel.ingredientItem(at: indexPath.row) ?? ("", "", ""))
            return cell
        case procedureTableView:
            let cell = procedureTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProcedureTableViewCell
            cell.configure(with: recipeDetailViewModel.procedureItem(at: indexPath.row) ?? (0, ""))
            return cell
        default:
            fatalError("TableView is  nil")
        }
    }
    
}
