//
//  ContentView.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/17/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel:HomeViewModel
    @State private var scale: CGFloat = 1
    @State private var angle: Double = 0
    
    var body: some View {
        NavigationView {
            VStack() {
                content()
                NavigationLink(
                    destination: DetailView()
                        .navigationBarTitle("")
                        .navigationBarHidden(false),
                    isActive: $viewModel.openDetailPage
                ) {
                    EmptyView()
                }
            }
        }
    }
    
    private func content() -> some View {
        return VStack {
            Button {
                scale += 1
                angle += 45
                self.viewModel.buttonTap()
            } label: {
//                Text("Update")
                Image("send")
                    .frame(width: 20,
                           height: 20,
                           alignment: .center)
                    .padding()
                    .background(Color.red)
                    .clipShape(Circle())
//                Text("Update")
//                    .font(Font.custom("montserrat_medium", size: 18))
            }
//            .scaleEffect(viewModel.showList ? 1.3 : 1.0)
//            .scaleEffect(scale)
            .rotationEffect(.degrees(angle))
            .animation(.easeIn, value: angle)
            
            if viewModel.showList {
                List(viewModel.animals) { animal in
                    AnimalRow(animal: animal)
                }
                .listStyle(.grouped)
            } else {
                Text("List is hidden")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
    }
    
    private func AnimalRow(animal: Animal) -> some View {
        return ZStack() {
            Text("Name: \(animal.name)")
                .fontWeight(.bold)
                .font(.title)
                .padding()
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(25)
                .padding(10)
                .border(Color.purple, width: 5)
        }
        .onTapGesture {
            print("tap gesture \(animal.name)")
            viewModel.openDetail()
        }
        .padding(.vertical, 10.0)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
