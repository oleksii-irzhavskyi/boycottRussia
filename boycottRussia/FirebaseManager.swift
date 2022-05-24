//
//  FirebaseManager.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 24.05.2022.
//

import Foundation
import Firebase
import FirebaseCore
import SwiftUI
import FirebaseStorage
import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private func configuratorFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getPost(collection: String, docName: String, completion: @escaping (BarcodeModel?) -> Void) {
        let db = configuratorFB()
        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
            guard error == nil else{completion(nil); return}
            let doc = BarcodeModel(Barcode: document?.get("Barcode") as! String, Name: document?.get("Name") as! String)
            completion(doc)
        })
    }
    
    func getImage(picName: String, completion: @escaping(UIImage) -> Void){
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")
        
        var image: UIImage = UIImage(named: "boycottRussiaLogo")!
        
        let fileRef = pathRef.child(picName + "lpeg")
        fileRef.getData(maxSize: 1024*1024, completion: { data, error in
            guard error == nil else {completion(image); return}
            image = UIImage(data: data!)!
            completion(image)
            
        })
        
    }
}
