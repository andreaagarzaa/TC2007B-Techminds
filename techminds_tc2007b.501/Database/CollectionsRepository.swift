//
//  CollectionsRepository.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 06/06/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Combine

class CollectionsRepository : ObservableObject {
    private let usersPath = "users"
    private let collectionsPath = "collections"
    private let store = Firestore.firestore()
    private let auth = Auth.auth()
    
    @Published private(set) var collections: [Collection] = []
    @Published private(set) var error: Error? = nil
    
    private var snapshotListenerHandle: ListenerRegistration? = nil
    private var authStateChangeListenerHandle: AuthStateDidChangeListenerHandle? = nil
    
    init() {
        authStateChangeListenerHandle = auth.addStateDidChangeListener(self.onAuthStateChange)
    }
    
    func onAuthStateChange(auth: Auth, authUser: FirebaseAuth.User?) {
        if let listener = snapshotListenerHandle {
            listener.remove()
        }
        
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let collectionsRef = store.collection(usersPath)
            .document(user.uid)
            .collection(collectionsPath)
            .order(by: "name")
        
        self.snapshotListenerHandle = collectionsRef.addSnapshotListener(self.onCollectionsChange)
    }
    
    func createCollection(name: String, color: Color) {
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let collectionRef = store.collection(usersPath).document(user.uid).collection(collectionsPath).document(UUID().uuidString)
        
        Task {
            do {
                let snapshot = try await collectionRef.getDocument()
                if snapshot.exists {
                    error = RepositoryError.alreadyExists
                    return
                }
                
                let newCollection = Collection(name: name, color: CodableColor(cgColor: color.cgColor ?? CGColor(gray: 1.0, alpha: 1.0)))
                try collectionRef.setData(from: newCollection) { error in
                    guard error == nil else {
                        return
                    }
                }
            } catch {
                self.error = error
            }
        }
        
    }
    
    func updateCollection(collection: Collection) {
        guard let collectionId = collection.id else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let collectionRef = store.collection(usersPath).document(user.uid).collection(collectionsPath).document(collectionId)
        do {
            try collectionRef.setData(from: collection)
        } catch {
            self.error = error
        }
    }
    
    func deleteCollection(collection: Collection) {
        guard let collectionId = collection.id else {
            self.error = RepositoryError.invalidModel
            return
        }
        
        guard let user = auth.currentUser else {
            self.error = RepositoryError.notAuthenticated
            return
        }
        
        let collectionRef = store.collection(usersPath).document(user.uid).collection(collectionsPath).document(collectionId)
        Task {
            do {
                try await collectionRef.delete()
            } catch {
                self.error = error
            }
        }
    }
    
    func onCollectionsChange(snapshot: QuerySnapshot?, error: Error?) {
        guard let snapshot = snapshot else {
            self.error = error
            return
        }
        do {
            self.collections = try snapshot.documents.map { snapshot in
                return try snapshot.data(as: Collection.self)
            }
        } catch {
            self.error = error
        }
    }
}