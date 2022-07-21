//
//  RatingListViewModel.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.07.2022.
//

import Foundation
import FirebaseDatabase

final class RatingListViewModel: ObservableObject {
    @Published var ratings: [Rating] = []
    
//    private lazy var databasePath: DatabaseReference? = {
//        let ref = Database.database(url: "https://boycott-russia-rating.europe-west1.firebasedatabase.app").reference().child("rating")
//        return ref
//    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(){
        listenRealtimeDatabase()
    }
    func listenRealtimeDatabase() {
        var storage: [Rating] = []
        let ref = Database.database(url: "https://boycott-russia-rating.europe-west1.firebasedatabase.app").reference().child("rating")
        let databasePath = ref
        databasePath
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String:Any]
                else{
                    return
                }
                json["id"] = snapshot.key
                do{
                    
                    let retingData = try JSONSerialization.data(withJSONObject: json)
                    let rating = try self.decoder.decode(Rating.self, from: retingData)
                    storage.append(rating)
                } catch {
                    print("an error occured", error)
                }
                self.ratings = storage.sorted {
                    $0.rating > $1.rating
                }
            }
        
    }
    
//    func stopListening(){
//        databasePath?.removeAllObservers()
//    }
}
