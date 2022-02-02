//
//  LoginViewModel.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/19/22.
//

import Foundation
import SwiftUI
import Firebase
import UserNotifications
import AVFoundation

class LoginViewModel: ObservableObject {
    
    @Published var openHomePage = false
    
    //Alert
    @Published var showAlert = false
    @Published var alertItem: AlertItem?
    
    @Published var isRegistered = false
    
    @Published var cameraPermissionGranted = false
    
    
    func validate(email:String, password:String, _ completion:@escaping (_ success:Bool) -> Void) {
        if email == "" || password == "" {
            completion(false)
            return
        }
        
//        loginViaFirebase(email: email, password: password)
        loginViaFirebase(email: email, password: password, { success in
            completion(success)
        })
    }
    
//    private func loginViaFirebase(email:String, password:String) {
//        let db = Firestore.firestore()
//        let userRef = db.collection("users")
//        userRef.whereField("email", isEqualTo: email)
//            .whereField("password", isEqualTo: password)
//            .getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                    self.isRegistered = true
//                }
//
//                if self.isRegistered {
//                    print("Login")
//                    //Open next page
//                    self.openHomePage = true
//                } else {
//                    //Display Alert
//                    self.alertItem = AlertItem(title: "Error", message: "Invalid Login")
//                    self.showAlert = true
//                }
//            }
//        }
//    }
    
    //handler: @escaping () -> Void
    //handler: @escaping (Result<Data?, Error>) -> Void
    private func loginViaFirebase(email:String, password:String, _ completion:@escaping (_ success:Bool) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users")
        userRef.whereField("email", isEqualTo: email)
            .whereField("password", isEqualTo: password)
            .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.isRegistered = true
                }
                
                completion(self.isRegistered)
            }
        }
    }
    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
            DispatchQueue.main.async {
                self.cameraPermissionGranted = accessGranted
            }
        })
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(title:String = "", message:String) {
        print("sendNotification")
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default

        // show this notification one second from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
