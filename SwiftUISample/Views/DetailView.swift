//
//  DetailView.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/17/22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack() {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .navigationTitle("Details")
        .navigationBarHidden(false)
        .onAppear() {
            print("display Detail")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
