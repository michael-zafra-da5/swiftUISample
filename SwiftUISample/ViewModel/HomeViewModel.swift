//
//  HomeViewModel.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/17/22.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class HomeViewModel: ObservableObject {
    
    @Published var animals = [
        Animal(name: "Cow"),
        Animal(name: "Horse"),
        Animal(name: "Sheep"),
        Animal(name: "Camel"),
        Animal(name: "Goat"),
        Animal(name: "Dog")
    ]
    
    @Published var animalsName = [
       "Cow",
       "Horse",
       "Sheep",
       "Camel",
       "Goat",
       "Dog"
    ]
    
    @Published var users:[UserData] = []
    private var cancellable: AnyCancellable?
    private var urlSession = URLSession.shared
    
    @Published var showList = true
    @Published var openDetailPage: Bool = false
    
    init() {
        
    }
    
    func buttonTap(value:String) {
        print("button Tap \(value)")
        showList = !showList
    }
    
    func openDetail() {
        print("openDetail function")
        openDetailPage = !openDetailPage
    }
    
    func setUsers(users:[UserData]) {
        self.users.removeAll()
        self.users = users
    }
    
    func removeRows(at offsets: IndexSet) {
        let beforeUpdate = animals
        animals.remove(atOffsets: offsets)
        print("beforeUpdate: \(beforeUpdate)")
        print("updated: \(animals)")
        let difference = animals.difference(from: beforeUpdate)
        print("difference: \(difference.last?.name ?? "")")
    }
    
    /// This function will response the response data for the given `page`.
    ///
    ///
    /// - Parameter page: Int.
    /// - Parameter completion: ListResponse.
    func getUsers(page:Int, completion:@escaping (ListResponse) -> ()) {
        guard let url = URL(string: "https://reqres.in/api/users?page=\(page)") else { return }
        print("URL \(url)")
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept") //for header
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: url, completionHandler: { data, res, err in
            do {
                if let jsonString = String(data: data!, encoding: .utf8) {
                    print("Response Data: \(jsonString)")
                }
                let comments = try JSONDecoder().decode(ListResponse.self, from: data!)
                print(comments)
                
                DispatchQueue.main.async {
                    completion(comments)
                }
            } catch {
                DispatchQueue.main.async {
                    let response = ListResponse(page: page, per_page: 0, total: 0, total_pages: 0, data: [])
                    completion(response)
                    print("ERROR:", error)
                }
            }
        })
        task.resume()
    }
    
    func getAppVer(platform:Int, then handler: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = URL(string: "http://192.168.254.141:8000/api/platform/versionChecker") else { return }
        print("URL \(url)")
        
        // Serialize HTTP Body data as JSON
        let body = [
            "platform": platform
//            "test":platform
        ] as [String : Any]
        let bodyData = (try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        ))!
        print("params: \(body)")
        // To ensure that our request is always sent, we tell
        // the system to ignore all local cache data:
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        
        request.httpMethod = "POST"
        request.httpBody = bodyData
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("com.da5.mobile/1.4.0 (MI MAX 2; Android N; Scale DisplayMetrics{density=2.75, width=1080, height=1920, scaledDensity=2.75, xdpi=342.9, ydpi=343.436})", forHTTPHeaderField: "User-Agent")
        
        
        let task = urlSession.dataTask(
            with: request,
            completionHandler: { data, response, error in
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response: \(String(describing: response))")
                        print("Request Header: \(request.allHTTPHeaderFields ?? [:]))")
                        print("Request Body: \(body))")
                        print("Response Data: \(jsonString)")
                    }
                }
                handler(.success(data))
            }
        )
        task.resume()
    }
    
    func readVersion(data:Data?) {
//        print("readVersion \(data)")
        if let d = data {
            if let value = String(data: d, encoding: String.Encoding.ascii) {
                print("readVersion \(value)")
            }
        }
    }
    
    func initMessage() {
        let db = Firestore.firestore()
        db.collection("messages").document("CeFB8Ampc3v7b8P2JWgj")
            .addSnapshotListener { documentSnapshot, error in
              guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
              }
              guard let data = document.data() else {
                print("Document data was empty.")
                return
              }
              print("Current data: \(data)")
//                self.message.text = "\(data["message"] ?? "")"
                
                
//                let developers = snapshot.documents.compactMap { (document) ->  Message? in
//                  var x: Message? = nil
//                    do {
//                      x = try document.data(as: Message.self)
//                    } catch {
//                    print(error)
//                    }
//                  return x
//                  }
            }
    }
}
