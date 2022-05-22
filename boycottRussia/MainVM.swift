//
//  MainVM.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.05.2022.
//

import Combine
import Foundation

final class MainVM: ObservableObject {
    // input
    @Published var searchCompany: String?
    // output
    @Published private var companyInfo = CompanyInfo()
    @Published var companyStatus: String = ""
    
    
    func fetchAPI(){
        guard let search = self.searchCompany?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
            self.companyStatus = "Введіть назву"
            print("ls,ls,sl")
            return
        }
        guard let url = URL(string: "https://api.boycottrussiabot.com/v1/companies/search?name=\(search)") else {
            print("aaaerror")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJvbGVrc2lpLmlyemhhdnNreWlAZ21haWwuY29tIiwiYXV0aEtleSI6Im4yN21CbjNMZzljMVBwS2RVM0pCRk5VOGVLcTNUSGUyIiwicGVybWlzc2lvbnMiOlsiY29tcGFueV9hcGlfc2VhcmNoIl0sImlhdCI6MTY1MzA1NTc3MH0.y7OtF48xt1LNNahDM-So8Eq72IhJdFwBDmjCaCTJxQo", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodeStatus = try? JSONDecoder().decode(CompanyInfo.self, from: data){
                    DispatchQueue.main.async {
                        if decodeStatus.isEmpty{
                            self.companyStatus="NEMA INFO"
                        } else{
                            self.companyStatus = decodeStatus[0].status ?? "NEMA"
                        }
                    }
                }
            }
//            if let error = error {
//                    print("Error took place \(error)")
//                    return
//                }
//
//                // Read HTTP Response Status code
//                if let response = response as? HTTPURLResponse {
//                    print("Response HTTP Status code: \(response.statusCode)")
//                }
//
//                // Convert HTTP Response Data to a simple String
//                if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                    print("Response data string:\n \(dataString)")
//                }
        }.resume()
    }
}
