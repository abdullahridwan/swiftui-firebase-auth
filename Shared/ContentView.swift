//
//  ContentView.swift
//  Shared
//
//  Created by Abdullah Ridwan on 5/27/21.
//

import SwiftUI
import FirebaseAuth



class AppViewModel: ObservableObject{
    let auth = Auth.auth()
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signedIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Sucessfully Signed In
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password){
            [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            //Sucessfully Signed Up
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
}


struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        NavigationView{
            if viewModel.signedIn{
                Text("You are signed in!")
            }else{
                SignInView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}




struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack(alignment: .leading){
                Text("Email Address").font(.title2)
                HStack{
                    Image(systemName: "envelope")
                    TextField("Email Address...", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Password").font(.title2)
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password...", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .padding(.top, 30)
            
            
            Button(action:{
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                viewModel.signedIn(email: email, password: password)
            }, label:{
                Text("Sign In")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    .foregroundColor(Color.white)
            })
            NavigationLink("Create an Account", destination: SignUpView())
                .padding(20)
            
            Spacer()
        }
        .navigationTitle("Sign In")
        .padding()
        
    }
}





struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack(alignment: .leading){
                Text("Email Address").font(.title2)
                HStack{
                    Image(systemName: "envelope")
                    TextField("Email Address...", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Password").font(.title2)
                HStack{
                    Image(systemName: "lock")
                    SecureField("Password...", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .padding(.top, 30)
            
            
            Button(action:{
                guard !email.isEmpty, !password.isEmpty else {
                    print("SignUp View Issue")
                    return
                }
                viewModel.signUp(email: email, password: password)
            }, label:{
                Text("Create Account")
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8.0)
                    .foregroundColor(Color.white)
            })
            
            
            Spacer()
        }
        .navigationTitle("Create an Account")
        .padding()
        
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
