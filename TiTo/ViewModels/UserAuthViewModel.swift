//
//  userAuthViewModel.swift
//  TiTo
//
//  Created by Arkadius Pielka on 08.01.24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import PhotosUI

class UserAuthViewModel: ObservableObject {
    
    init() {
        checkAuth()
    }
    
    @Published var user: FireUser?
    @Published var productUser: FireUser?
    
    @Published var selectedImage: PhotosPickerItem?
        @Published var selectedImageData: Data?
    
    
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
    
    func fetchProductOwner(with id: String) {
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
                self.productUser = user
            } catch {
                print("Dokument ist kein User", error.localizedDescription)
            }
        }
    }
    
    func updateUser(user: FireUser) {
        
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let user = ["plz": user.plz,
                    "name": user.name,
                    "email": user.email,
                    "housenumber": user.housenumber,
                    "street": user.street,
                    "country": user.country,
                    "city": user.city
        ]
        FirebaseManager.shared.database.collection("users").document(userId).setData(user as [String : Any], merge: true) { error in
            if let error {
                print("Profil wurde nicht aktualisiert", error.localizedDescription)
                return
            }
            
            print("Profil aktualisiert!")
        }
        updateImage(id: userId)
        fetchUser(with: userId)
    }
    
    func updateImage(id: String) {
        
        guard let userId = FirebaseManager.shared.userId, let selectedImageData = selectedImageData else { return }
        
        let reference = FirebaseManager.shared.storage.reference().child(userId).child("profilImage").child("\(id).jpg")
        
        reference.putData(selectedImageData, metadata: nil) { _, error in
            if let error {
                print("Image upload failed!", error)
                return
            }
            
            self.getImageURL(from: reference, id: id)
        }
    }
    
    private func getImageURL(from reference: StorageReference, id: String) {
        
        reference.downloadURL { url, error in
            if let error {
                print("Image upload failed!", error)
                return
            }
            
            guard let url else {
                print("We don't have a URL, something went wrong!")
                return
            }
            
            let data = ["imageURL": url.absoluteString]
            self.updateUserImage(id: id, with: data)
        }
    }
    
    private func updateUserImage(id: String, with data: [String: String]) {
        FirebaseManager.shared.database.collection("users").document(id).setData(data, merge: true) { error in
            if let error {
                print("Task wurde nicht aktualisiert", error.localizedDescription)
                return
            }
            
            print("Task aktualisiert!")
        }
    }
}
