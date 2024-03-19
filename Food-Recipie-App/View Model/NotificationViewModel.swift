//
//  NotificationViewModel.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import Foundation

class NotificationViewModel {
    private let databaseManager: DatabaseManager
        
        var notifications: [Notification] = []
        var filteredNotifications: [Notification] = []
        var filterState: FilterState = .all
        
        init(databaseManager: DatabaseManager) {
            self.databaseManager = databaseManager
        }
        
        func fetchNotifications(completion: @escaping () -> Void) {
            databaseManager.fetchNotifications { [weak self] notifications in
                self?.notifications = notifications
                self?.filteredNotifications = notifications
                completion()
            }
        }
        
        func filterNotifications() {
            switch filterState {
            case .all:
                filteredNotifications = notifications
            case .read:
                filteredNotifications = notifications.filter { $0.isRead }
            case .unread:
                filteredNotifications = notifications.filter { !$0.isRead }
            }
        }
}
