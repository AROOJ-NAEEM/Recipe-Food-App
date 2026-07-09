//
//  DatabaseManager.swift
//  Food-Recipie-App
//
//  Created by Dev on 3/14/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class DatabaseManager {
    static let shared = DatabaseManager()
    private let db = Firestore.firestore()
    private let authManager = Auth.auth()
    
    private init() {}
    
    func fetchName(completion: @escaping (String?) -> Void) {
        if let user = authManager.currentUser {
            let userUID = user.uid
            db.collection("users").document(userUID).getDocument { snapshot, error in
                if error != nil {
                    print("Error while getting data from database")
                    completion(nil)
                }
                else {
                    if let name = snapshot?.get("name") as? String {
                        completion(name)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    func loadRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        var recipes : [Recipe] = []
        
        db.collection("recipes").getDocuments { querySnapshot, error in
            if let e = error {
                print("Error while retrieving data from firestore, \(e)")
                completion(nil, error)
            } else {
                if let queryDocuments = querySnapshot?.documents {
                    for doc in queryDocuments {
                        let data = doc.data()
                        if let recipe = Recipe(data: data) {
                            recipes.append(recipe)
                       }
                    }
                    completion(recipes, nil)
                }
            }
        }

    }
    
    func createUser(withUID uid: String, userName: String, completion: @escaping (Error?) -> Void) {
        let userData = ["name": userName]
        db.collection("users").document(uid).setData(userData) { error in
            completion(error)
        }
    }
    func fetchNotifications(completion: @escaping ([Notification]) -> Void) {
            db.collection("notifications").getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(String(describing: error))")
                    completion([])
                    return
                }
                
                let notifications = documents.compactMap { queryDocumentSnapshot -> Notification? in
                    let data = queryDocumentSnapshot.data()
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let timeAgo = data["timeAgo"] as? String ?? ""
                    let isRead = data["isRead"] as? Bool ?? false
                    return Notification(title: title, description: description, timeAgo: timeAgo, isRead: isRead)
                }
                
                completion(notifications)
            }
        }
    
    func updateRecipeStatus(withName name: String) {
        db.collection("recipes")
            .whereField("name", isEqualTo: name)
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
                        let recipeRef = self.db.collection("recipes").document(recipeID)
                        recipeRef.updateData(["status": true]) { error in
                            if let error = error {
                                print("Error updating document: \(error)")
                            } else {
                                print("Document successfully updated")
                            }
                        }
                    } else {
                        print("Recipe with name '\(name)' not found")
                    }
                }
            }
    }
    
    func sendPasswordResetEmail(to email: String, completion: @escaping (String?, Error?) -> Void) {
        authManager.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(nil, error)
            } else {
                completion("Password reset email sent successfully.", nil)
            }
        }
    }

}
