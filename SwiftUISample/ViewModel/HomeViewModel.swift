//
//  HomeViewModel.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/17/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var animals = [
        Animal(name: "Cow"),
        Animal(name: "Horse"),
        Animal(name: "Sheep"),
        Animal(name: "Camel"),
        Animal(name: "Goat"),
        Animal(name: "Dog")
    ]
    
    @Published var showList = true
    @Published var openDetailPage: Bool = false
    
    init() {
        
    }
    
    func buttonTap() {
        print("button Tap")
        showList = !showList
    }
    
    func openDetail() {
        print("openDetail function")
        openDetailPage = !openDetailPage
    }
}
