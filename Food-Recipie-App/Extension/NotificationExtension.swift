//
//  NotificationExtension.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import Foundation
import UIKit

extension NotificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case todayCollectionView:
            let filteredNotifications: [Notification]
            filteredNotifications = viewModel.filteredNotifications
            return filteredNotifications.count
        case yesterdayCollectionView:
            let newFilteredNotifications: [Notification]
            newFilteredNotifications = viewModel.filteredNotifications
            return newFilteredNotifications.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case todayCollectionView:
            let cell = todayCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NotificationCollectionViewCell
            let filteredNotifications: [Notification]
            filteredNotifications = viewModel.filteredNotifications
            let notification = filteredNotifications[indexPath.item]
            cell.configure(with: notification)
            
            return cell
        case yesterdayCollectionView:
            let cell = yesterdayCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! YesterdayCollectionViewCell
            let newFilteredNotifications: [Notification]
            newFilteredNotifications = viewModel.filteredNotifications
            let notification = newFilteredNotifications[indexPath.item]
            cell.configure(with: notification)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func updateCollectionView() {
        viewModel.filterNotifications()
        todayCollectionView.reloadData()
        yesterdayCollectionView.reloadData()
    }

    
}
