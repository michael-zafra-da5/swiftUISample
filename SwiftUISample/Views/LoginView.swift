//
//  LoginView.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/19/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel:LoginViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack() {
            Image("logo")
                .aspectRatio(contentMode: .fit)
                .frame(width: 25,
                       height: 25)
            
            VStack {
                VStack(alignment: HorizontalAlignment.leading) {
                    Text("Email")
                        .foregroundColor(.black)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                        .frame(height: 24.0)

                    Text("Password")
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                        .frame(height: 32.0)
                    
                    Button {
                        //Action
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10.0)
                    .background(.blue)
                    .cornerRadius(5)
                }
                .padding(30)
                .multilineTextAlignment(.center)
            }
            .frame(width: UIScreen.screenWidth-40)
            .background(
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.white)
                    .shadow(radius: 5))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
        .background(Color.init(hex: "#66b3ff"))
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = LoginViewModel()
//        LoginView()
//            .environmentObject(viewModel)
//    }
//}
