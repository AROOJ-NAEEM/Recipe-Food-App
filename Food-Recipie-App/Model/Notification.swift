//
//  Notification.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/19/24.
//

import Foundation

struct Notification {
    let title: String
    let description: String
    let timeAgo: String
    var isRead: Bool
}

//let notifications: [Notification] = [
//            Notification(title: "New Recipe Alert!", description: "Lorem Ipsum tempor incididunt ut labore et dolore,in voluptate velit esse cillum", timeAgo: "10 mins ago", isRead: false),
//            Notification(title: "New Recipe Alert!", description: "Lorem Ipsum tempor incididunt ut labore et dolore,in voluptate velit esse cillum", timeAgo: "30 mins ago", isRead: true),
//            Notification(title: "Save Recipe Alert!", description: "Lorem Ipsum tempor incididunt ut labore et dolore,in voluptate velit esse cillum", timeAgo: "30 mins ago", isRead: false)
//
//        ]
//
//        // Initialize Firestore
//        let db = Firestore.firestore()
//
//        // Iterate over each notification and store it in Firestore
//        for notification in notifications {
//            // Add a new document with a generated ID
//            var ref: DocumentReference? = nil
//            ref = db.collection("notifications").addDocument(data: [
//                "title": notification.title,
//                "description": notification.description,
//                "timeAgo": notification.timeAgo,
//                "isRead": notification.isRead
//            ]) { err in
//                if let err = err {
//                    print("Error adding document: \(err)")
//                } else {
//                    print("Document added with ID: \(ref!.documentID)")
//                }
//            }
//        }
