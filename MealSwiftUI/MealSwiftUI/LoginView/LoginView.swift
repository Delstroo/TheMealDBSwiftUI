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
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        
        super.init()
    }
}

struct LoginView: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @State private var isPopupVisible = false
    
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
                            shouldShowImagePicker.toggle()
                        } label: {
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 120))
                                        .foregroundColor(Color(uiColor: .label))
                                        .overlay(RoundedRectangle(cornerRadius: 120).stroke(Color(uiColor: .label), lineWidth: 3))
                                }
                            }
                            .padding()
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
                    
                    
                    // Use the custom popup view with scale effect
                    ZStack {
                        if isPopupVisible {
                            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    isPopupVisible = false
                                }
                            
                            PopupView(isPresented: $isPopupVisible, message: $loginStatusMessage)
                                .scaleEffect(isPopupVisible ? 1.0 : 0.1)
                                .opacity(isPopupVisible ? 1.0 : 0.0)
                                .animation(.easeInOut(duration: 0.3))
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(isLoginMode ? "Login" : "Create Account")
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $image)
        }
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
                self.isPopupVisible = true
                return
            }
//            self.loginStatusMessage = "Succ created user, \(result?.user.uid ?? "")"
            
            self.persistImageToStorage()
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                self.loginStatusMessage = "Failed to login: \(error?.localizedDescription ?? "")"
                self.isPopupVisible = true
                return
            }
//            self.loginStatusMessage = "Succ logged in, welcome back \(result?.user.uid ?? "")"
        }
    }
    
    private func persistImageToStorage() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid,
        let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        
        ref.putData(imageData, metadata: nil) { metaData, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to storage: \(err.localizedDescription)"
                self.isPopupVisible = true
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    self.isPopupVisible = true
                    return
                }
                
//                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


struct PopupView: View {
    @Binding var isPresented: Bool
    @Binding var message: String

    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.red)
                .padding()
            
            Button("Dismiss") {
                isPresented = false
                message = ""
            }
        }
        .frame(width: 300, height: 150)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(10)
    }
}
