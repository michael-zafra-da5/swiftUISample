//
//  SwiftUISVG.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/28/22.
//

import Foundation
import SwiftUI
import UIKit
import Elephant

struct SVGUIView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<SVGUIView>) -> SVGView {
        let uiView = SVGView(named: "logo", animationOwner: .css, style: .cssFile(name: "logo-animation"))
//        let uiView = SVGView(named: "image", animationOwner: .css, style: .cssFile(name: "logo-animation"))
        return uiView
    }
    
    func updateUIView(_ uiView: SVGView, context: UIViewRepresentableContext<SVGUIView>) {
        print("updateUIView")
        NSLayoutConstraint.activate([
            uiView.centerXAnchor.constraint(equalTo: uiView.superview!.centerXAnchor),
            uiView.centerYAnchor.constraint(equalTo: uiView.superview!.centerYAnchor),
            uiView.widthAnchor.constraint(equalToConstant: 128),
            uiView.heightAnchor.constraint(equalToConstant: 128),
        ])
        uiView.backgroundColor = UIColor.blue
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.startAnimation()
    }
    
}
