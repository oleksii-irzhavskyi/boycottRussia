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
    private let databaseSuggesion = Database.database(url: "https://boycott-russia.europe-west1.firebasedatabase.app")
    private let databaseRating = Database.database(url: "https://boycott-russia-rating.europe-west1.firebasedatabase.app")
    
    func addNewSuggestion(object:Any) {
        let id = Date()
        databaseSuggesion.reference().child("newSuggestion_\(id)").setValue(object)
    }
    
    func updateRating(company: String, reaction: String) {
//        databaseRating.reference().child("\(company)").setValue(ServerValue.increment(1))
        databaseRating.reference().child("rating").child("\(company)").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                if reaction == "plus"{
                    self.databaseRating.reference().child("rating").child("\(company)").child("rating").setValue(ServerValue.increment(1))
                } else {
                    self.databaseRating.reference().child("rating").child("\(company)").child("rating").setValue(ServerValue.increment(-1))
                }
                print("all good")
            }else{
                if reaction == "plus"{
                    self.databaseRating.reference().child("rating").child("\(company)").setValue(["id":"\(randomString(length: 12))","name":company,"rating":1])
                }else {
                    self.databaseRating.reference().child("rating").child("\(company)").setValue(["id":"\(randomString(length: 12))","name":company,"rating":-1])
                }
                print("new")
            }
        })
    }
    static let shared = FirebaseManager()
    
    private func configuratorFB() -> Firestore {
        var database: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        database = Firestore.firestore()
        return database
    }
    
    func getPost(collection: String, docName: String, completion: @escaping (BarcodeModel?) -> Void) {
        let database = configuratorFB()
        database.collection(collection).document(docName).getDocument(completion: { (document, error) in
            guard error == nil else {completion(nil); return}
            let doc = BarcodeModel(barcode: document?.get("Barcode") as? String, name: document?.get("Name") as? String)
            completion(doc)
        })
    }
    
    func getImage(picName: String, completion: @escaping(UIImage) -> Void) {
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
