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
        if collectionView == todayCollectionView {
            let filteredNotifications: [Notification]
            switch viewModel.filterState {
            case .all:
                filteredNotifications = viewModel.notifications
            case .read:
                filteredNotifications = viewModel.notifications.filter { $0.isRead }
            case .unread:
                filteredNotifications = viewModel.notifications.filter { !$0.isRead }
            }
            return filteredNotifications.count
        } else if collectionView == yesterdayCollectionView {
            let newFilteredNotifications: [Notification]
            switch viewModel.filterState {
            case .all:
                newFilteredNotifications = viewModel.notifications
            case .read:
                newFilteredNotifications = viewModel.notifications.filter { $0.isRead }
            case .unread:
                newFilteredNotifications = viewModel.notifications.filter { !$0.isRead }
            }
            return newFilteredNotifications.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == todayCollectionView {
            let cell = todayCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NotificationCollectionViewCell
            let filteredNotifications: [Notification]
            switch viewModel.filterState {
            case .all:
                filteredNotifications = viewModel.notifications
            case .read:
                filteredNotifications = viewModel.notifications.filter { $0.isRead }
            case .unread:
                filteredNotifications = viewModel.notifications.filter { !$0.isRead }
            }
            
            let notification = filteredNotifications[indexPath.item]
            cell.notiTitile.text = notification.title
            cell.notiDiscription.text = notification.description
            cell.notiTime.text = notification.timeAgo
            cell.configure(isRead: notification.isRead)
            
            return cell
        } else if collectionView == yesterdayCollectionView {
            let cell = yesterdayCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! YesterdayCollectionViewCell
            let newFilteredNotifications: [Notification]
            switch viewModel.filterState {
            case .all:
                newFilteredNotifications = viewModel.notifications
            case .read:
                newFilteredNotifications = viewModel.notifications.filter { $0.isRead }
            case .unread:
                newFilteredNotifications = viewModel.notifications.filter { !$0.isRead }
            }
            
            let notification = newFilteredNotifications[indexPath.item]
            cell.notiTitile.text = notification.title
            cell.notiDiscription.text = notification.description
            cell.notiTime.text = notification.timeAgo
            cell.configure(isRead: notification.isRead)
                
            return cell
        }
        return UICollectionViewCell()
    }
    
    func updateCollectionView() {
        viewModel.filterNotifications()
        todayCollectionView.reloadData()
        yesterdayCollectionView.reloadData()
    }

    
}
