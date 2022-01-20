//
//  LoginViewModel.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/19/22.
//

import Foundation
import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    
    @Published var openHomePage = false
    
    //Alert
    @Published var showAlert = false
    @Published var alertItem: AlertItem?
    
    func validate(email:String, password:String) {
        if email == "" || password == "" {
            self.alertItem = AlertItem(title: "Error", message: "Email or Password is required")
            self.showAlert = true
            return
        }
        
        loginViaFirebase(email: email, password: password)
    }
    
    private func loginViaFirebase(email:String, password:String) {
        let db = Firestore.firestore()
        var isRegistered = false
        let userRef = db.collection("users")
        userRef.whereField("email", isEqualTo: email)
            .whereField("password", isEqualTo: password)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    isRegistered = true
                }
                
                if isRegistered {
                    print("Login")
                    //Open next page
                    self.openHomePage = true
                } else {
                    //Display Alert
                    self.alertItem = AlertItem(title: "Error", message: "Invalid Login")
                    self.showAlert = true
                }
            }
        }
    }
}
