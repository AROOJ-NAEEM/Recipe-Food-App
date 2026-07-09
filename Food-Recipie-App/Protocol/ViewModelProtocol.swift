//
//  ViewModelProtocol.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/24/24.
//

import Foundation

protocol SplashViewModelProtocol {
    func isUserAuthenticated() -> Bool
}

protocol LoginViewModelDelegate: AnyObject {
    func loginDidSucceed()
    func loginDidFail(withError error: Error)
}

protocol AuthenticationDelegate: AnyObject {
    func signUpDidSucceed(user: User)
    func signInDidSucceed(user: User)
    func authenticationDidFail(withError error: Error)
    func navigateToHomeScreen()
}

protocol RecipeCellDelegate: AnyObject {
    func didPressSaveButton(in cell: RecipeCollectionViewCell)
}

protocol CategoryCellDelegate: AnyObject {
    func categoryButtonPressed(withOrigin origin: String)
}

protocol FilterButtonDelegate: AnyObject {
    func filterButtonPressed()
}

protocol SavedRecipeDelegate: AnyObject {
    func recipesDidChange()
}
protocol RecipeSaveButtonDelegate: AnyObject {
    func didPressSaveButton()
}

