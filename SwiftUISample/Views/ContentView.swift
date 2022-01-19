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
                List {
                    ForEach(0..<viewModel.users.count) { index in
                        let user = viewModel.users[index]
                        HStack(alignment: .center) {
                            if #available(iOS 15.0, *) {
                                AsyncImage(url: URL(string:user.avatar))
                                .cornerRadius(180.0/2)
                                .frame(width: 180.0, height: 180.0)
                            } else {
                                ImageView(withURL: user.avatar)
                            }
                            Text("\(user.first_name) \(user.last_name)")
                        }
                    }
                }
                .listStyle(.grouped)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .onAppear() {
            viewModel.initMessage()
            viewModel.getUsers(page: 1,completion: { response in
                print("getuser response: \(response)")
                viewModel.setUsers(users: response.data)
            })
            
            viewModel.getAppVer(platform: 1, then: {
                result in
                switch result {
                case .success(let data):
                  print("we have new data!")
                    viewModel.readVersion(data: data)
                case .failure(let error):
                  print("we have an error! \(error)")
                }
              })
        }
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
