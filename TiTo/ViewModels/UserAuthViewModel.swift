//
//  userAuthViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import Foundation
import FirebaseAuth

class UserAuthViewModel: ObservableObject {
    
    init() {
        checkAuth()
    }
    
    @Published var user: FireUser?
    
    
    var userLogIn: Bool {
        FirebaseManager.shared.auth.currentUser != nil
    }
    
    
    private func checkAuth() {
        guard let currentUser = FirebaseManager.shared.auth.currentUser else {
            print("Not logged in")
            return
        }
        
        self.fetchUser(with: currentUser.uid)
    }
    
    
    func logIn(email: String, password: String) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Login failed:", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is logged in with id '\(authResult.user.uid)'")
            
            self.fetchUser(with: authResult.user.uid)
        }
    }
    
    func signUp(email: String, name: String, password: String, kontoType: String) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                print("SignUp failed:", error.localizedDescription)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is logged in with id '\(authResult.user.uid)'")
            
            self.createUser(with: authResult.user.uid, email: email, name: name, kontoType: kontoType)
            
            self.logIn(email: email, password: password)
        }
    }
    
    func logOut() {
        do {
            try FirebaseManager.shared.auth.signOut()
            self.user = nil
        } catch {
            print(error)
        }
    }
    
    func deleteUser() {
        
        FirebaseManager.shared.database.collection("users").document(user!.id).delete { error in
            if let error = error {
                print("Fehler beim Löschen des Firestore-Dokuments: \(error.localizedDescription)")
                return
            }
            
            FirebaseManager.shared.auth.currentUser?.delete()
        }
        logOut()
    }
    
    func createUser(with id: String, email: String, name: String, kontoType: String) {
        let user = FireUser(id: id, name: name, email: email, registeredAt: Date(), kontoType: kontoType)
        
        do {
            try FirebaseManager.shared.database.collection("users").document(id).setData(from: user)
        } catch let error {
            print("Fehler beim Speichern des Users: \(error)")
        }
    }
    
    func fetchUser(with id: String) {
        FirebaseManager.shared.database.collection("users").document(id).getDocument { document, error in
            if let error {
                print("Fetching user failed:", error.localizedDescription)
                return
            }
            
            guard let document else {
                print("Dokument existiert nicht!")
                return
            }
            
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Dokument ist kein User", error.localizedDescription)
            }
        }
    }
}
