//
//  ViewProtocol.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/24/24.
//

import Foundation

protocol SplashViewDelegate: AnyObject {
    func navigateToInitialScreen(isAuthenticated: Bool)
}
