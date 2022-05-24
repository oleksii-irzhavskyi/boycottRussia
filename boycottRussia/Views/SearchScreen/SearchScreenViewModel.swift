//
//  MainVM.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.05.2022.
//

import Combine
import Foundation

final class SearchScreenViewModel: ObservableObject {
    // input
    @Published var searchCompany = ""
    @Published var searchBarcode = ""
    // output
    @Published var isValid = false
    @Published var companyStatus: String = ""
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
//        self.$searchCompany
//            .debounce(for: 0.3, scheduler: RunLoop.main)
//            .removeDuplicates()
//            .flatMap { (plate: String?) -> AnyPublisher < CompanyInfo, Never> in
//                fetchAPI(for: plate)
//              }
//            .print("aaaaaaaa")
//            .assign(to: \.companyStatus, on: self)
//            .store(in: &self.cancellableSet)
        $searchCompany
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ input in
                return input.count >= 3
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    func getbarcodeInfo() {
        FirebaseManager.shared.getPost(collection: "companyBarcode", docName: searchBarcode, completion: {doc in
            guard doc != nil else {return}
            self.searchCompany = doc?.Name ?? "Nena info"
            self.fetchAPI()
        })
    }
    func fetchAPI() {
        guard let search = self.searchCompany.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{
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
                            self.companyStatus="🤔 Цієї компанії чи товару ще немає в нашій базі. Проте ми вже у пошуках 😉"
                        } else{
                            self.companyStatus = self.getStatus(decodeStatus: decodeStatus)
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
//       return
//        URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .print("aaadatatask")
//            .decode(type: CompanyInfo.self, decoder: JSONDecoder())
//            .catch { _ in Just(CompanyInfo())}
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
    }
    
    func getStatus (decodeStatus: CompanyInfo) -> String {
        if decodeStatus[0].status == "clear"{
            return "🟢 \(decodeStatus[0].name ?? "компанія") не веде бізнес на росії 👌"
        }
        if decodeStatus[0].status == "russian"{
            return "🔴 \(decodeStatus[0].name ?? "компанія") - компанія країни-агресора 🤬🤬🤬"
        }
        if decodeStatus[0].status == "not_out"{
            return " Бойкот! \(decodeStatus[0].name ?? "компанія")  не покинула ринок росії!"
        }
        if decodeStatus[0].status == "darkness"{
            return "🟢 \(decodeStatus[0].name ?? "компанія") не веде бізнес на росії 👌"
        }
        if decodeStatus[0].status == "ukrainian"{
            return "\(decodeStatus[0].name ?? "компанія") 🇺🇦 Це наше, українське!"
        }
        if decodeStatus[0].status == "partially_out"{
            return "🟠 \(decodeStatus[0].name ?? "компанія") заявила, що призупиняє або скорочує свою діяльність на росії 🤔"
        }
        if decodeStatus[0].status == "out_of_ukraine"{
            return "\(decodeStatus[0].name ?? "компанія") не веде бізнес в Україні"
        }
        if decodeStatus[0].status == "publicly_silence"{
            return "\(decodeStatus[0].name ?? "компанія") замовчує"
        }
        if decodeStatus[0].status == "russian_collaborator"{
            return " \(decodeStatus[0].name ?? "компанія") є колаборантом"
        }
        return ""
    }
}
