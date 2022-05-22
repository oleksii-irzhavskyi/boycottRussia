//
//  FetchData.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 20.05.2022.
//

import Foundation
class FetchData: ObservableObject {
    
    @Published var resultData = Data()
    
    init(url: String) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.resultData = data
            }
        }
        
    }
    
}
