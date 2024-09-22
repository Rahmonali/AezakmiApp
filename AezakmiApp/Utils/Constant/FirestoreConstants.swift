//
//  FirestoreConstants.swift
//  AezakmiApp
//
//  Created by Rahmonali on 21/09/24.
//

import FirebaseFirestore

struct FirestoreConstants {
    private static let Root = Firestore.firestore()
    
    static let UserCollection = Root.collection("users")
}
