//
//  LoginView.swift
//  MealSwiftUI
//
//  Created by Delstun McCray on 8/30/23.
//

import SwiftUI
import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        
        super.init()
    }
}

struct LoginView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    } label: {
                    }
                    .pickerStyle(.segmented)
                    
                    if !isLoginMode {
                        Button {
                            
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(15)
                    
                    Button {
                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Login" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        .background(.blue)
                        .cornerRadius(20)
                        .padding(.top, 25)
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                    
                }
                .padding()
            }
        }
        .navigationTitle(isLoginMode ? "Login" : "Create Account")
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleAction() {
        if isLoginMode {
            loginUser()
        } else {
            createNewAccount()
        }
    }
    
    @State var loginStatusMessage = ""
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                self.loginStatusMessage = "Failed to create user: \(err.localizedDescription)"
                return 
            }
            print("Succ created user, \(result?.user.uid ?? "")")
            self.loginStatusMessage = "Succ created user, \(result?.user.uid ?? "")"
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                self.loginStatusMessage = "Failed to login: \(error?.localizedDescription ?? "")"
                return
            }
            self.loginStatusMessage = "Succ logged in, welcome back \(result?.user.uid ?? "")"
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
