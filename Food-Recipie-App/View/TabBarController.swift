//
//  TabBarController.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import UIKit

class TabBarItem: UITabBarItem {
    var badgeView: UIView?
}

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, viewController) in viewControllers!.enumerated() {
                    // Customize the appearance of the tab bar item
                    if let item = tabBar.items?[index] as? TabBarItem {
                        // Check if the view controller is the one where you want to add the line
                        if viewController is HomeViewController {
                            // Create a custom view for the badge
                            let badgeView = createBadgeView()
                            item.badgeView = badgeView
                        }
                    }
                }
            }

            func createBadgeView() -> UIView {
                let badgeView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                badgeView.backgroundColor = .red
                
                // Create the line view
                let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 2))
                lineView.backgroundColor = .red
                
                // Add the line view to the badge view
                badgeView.addSubview(lineView)
                
                // Position the line view at the bottom of the badge view
                lineView.center = CGPoint(x: badgeView.bounds.width / 2, y: badgeView.bounds.height)
                
                return badgeView
            }

}

