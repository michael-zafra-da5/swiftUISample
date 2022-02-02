//
//  LoginView.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/19/22.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel:LoginViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let yposition = (geometry.size.height / 2) - (128)
                
                VStack() {
                    VStack {
//                        if colorScheme == .dark {
//                            Image("logo_dark")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 128,
//                                       height: 128)
//                        } else {
//                            Image("logo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 128,
//                                       height: 128)
//                        }
                        
                        SVGUIView()
                            .background(colorScheme == .dark ? Color.init(hex: "#16537E") : (Color.init(hex: "#66b3ff")))
                            .frame(width: 128,
                                   height: 128)
                        
                        
                        Spacer()
                            .frame(height: 62.0)
                        
                        VStack {
                            VStack(alignment: HorizontalAlignment.leading, spacing: 4) {
                                Text("Email")
                                    .foregroundColor(.black)
                                
                                TextField("Email", text: $email)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.leading)
                                    .autocapitalization(.none)
                                    .accessibility(identifier: "emailTF")
                                
                                Spacer()
                                    .frame(height: 18.0)
                                
                                Text("Password")
                                    .foregroundColor(.black)
                                
                                SecureField("Password", text: $password)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.leading)
                                    .autocapitalization(.none)
                                    .accessibility(identifier: "passwordTF")
                                
                                Spacer()
                                    .frame(height: 24.0)
                                
                                Button {
                                    viewModel.validate(email: email, password: password, { success in
                                        if success {
                                            print("Login")
                                            //Open next page
                                            self.viewModel.sendNotification(title:"Login Successful", message: "You are now logged in!")
                                            self.viewModel.openHomePage = true
                                        } else {
                                            print("Fail")
                                            //Display Alert
                                            self.viewModel.alertItem = AlertItem(title: "Error", message: "Invalid Login")
                                            self.viewModel.showAlert = true
                                        }
                                    })
                                } label: {
                                    Text("Login")
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10.0)
                                .background(.blue)
                                .cornerRadius(5)
                            }
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 30.0)
                            .multilineTextAlignment(.center)
                        }
                        .frame(width: UIScreen.screenWidth-40, height: 250)
                        .background(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.white)
                                .shadow(radius: 5))
                    }
                    .position(x: geometry.size.width / 2, y: yposition)
                    
                    let homeViewModel = HomeViewModel()
                    NavigationLink(
                        destination: ContentView(email: email, testing: "").environmentObject(homeViewModel)
                            .navigationBarTitle("")
                            .navigationBarHidden(true),
                        isActive: $viewModel.openHomePage
                    ) {
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .background(colorScheme == .dark ? Color.init(hex: "#16537E") : (Color.init(hex: "#66b3ff")))
                .alert(item: $viewModel.alertItem) { show in
                    Alert(title: Text(show.title), message: Text(show.message), dismissButton: .default(Text("OK")))
                }
            }
            .onAppear {
                viewModel.requestNotificationAuthorization()
                viewModel.requestCameraPermission()
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = LoginViewModel()
//        LoginView()
//            .environmentObject(viewModel)
//    }
//}
