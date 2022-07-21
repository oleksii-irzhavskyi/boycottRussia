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
    @Published var company = ""
    // output
    @Published var isValid = false
    @Published var companyStatus: String = "Для отримання інформації введіть назву товару або компанії у спеціальному полі нижче або скористайтесь штрих-код сканером"
    @Published var companyCircle: String = "🇺🇦"
    @Published var ratingHide: Bool = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        $searchCompany
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { input in
                return input.count >= 3
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    func getbarcodeInfo() {
        if searchBarcode.isNumeric{
        FirebaseManager.shared.getPost(collection: "companyBarcode", docName: searchBarcode, completion: {doc in
            guard doc != nil else {return}
            self.searchCompany = doc?.name ?? "Немає інформації"
            self.fetchAPI()
            if self.searchCompany == "Немає інформації"{
                self.searchCompany = ""
            }
        })
        }else{
            self.companyStatus = "Отриманий штрих-код містить помилку."
        }
    }
    func fetchAPI() {
        guard let search = self.searchCompany.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            self.companyStatus = "Введіть назву"
            return
        }
        guard let url = URL(string: "https://api.boycottrussiabot.com/v1/companies/search?name=\(search)") else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiZW1haWwiOiJvbGVrc2lpLmlyemhhdnNreWlAZ21haWwuY29tIiwiYXV0aEtleSI6Im4yN21CbjNMZzljMVBwS2RVM0pCRk5VOGVLcTNUSGUyIiwicGVybWlzc2lvbnMiOlsiY29tcGFueV9hcGlfc2VhcmNoIl0sImlhdCI6MTY1MzA1NTc3MH0.y7OtF48xt1LNNahDM-So8Eq72IhJdFwBDmjCaCTJxQo", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let decodeStatus = try? JSONDecoder().decode(CompanyInfo.self, from: data) {
                    DispatchQueue.main.async {
                        if decodeStatus.isEmpty {
                            self.companyStatus="Цієї компанії чи товару ще немає в нашій базі. Проте ми вже у пошуках"
                            self.companyCircle="🤔"
                            self.ratingHide = false
                        } else {
                            self.companyStatus = self.getStatus(decodeStatus: decodeStatus)
                            self.company = decodeStatus[0].name!
                            self.ratingHide = true
                        }
                    }
                }
            }
        }.resume()
    }
    
    func addReaction(reaction: String) {
        FirebaseManager.shared.updateRating(company: company, reaction: reaction)
    }
    
    func getStatus (decodeStatus: CompanyInfo) -> String {
        if decodeStatus[0].status == "clear"{
            self.companyCircle="🟢"
            return " \(decodeStatus[0].name ?? "компанія") не веде бізнес на росії"
        }
        if decodeStatus[0].status == "russian"{
            self.companyCircle="🔴"
            return "\(decodeStatus[0].name ?? "компанія") - компанія країни-агресора"
        }
        if decodeStatus[0].status == "not_out"{
            self.companyCircle="🔴"
            return " Бойкот! \(decodeStatus[0].name ?? "компанія")  не покинула ринок росії!"
        }
        if decodeStatus[0].status == "darkness"{
            self.companyCircle="🟢"
            return "\(decodeStatus[0].name ?? "компанія") не веде бізнес на росії"
        }
        if decodeStatus[0].status == "ukrainian"{
            self.companyCircle="🇺🇦"
            return "\(decodeStatus[0].name ?? "компанія")- Це наше, українське!"
        }
        if decodeStatus[0].status == "partially_out"{
            self.companyCircle="🟠"
            return " \(decodeStatus[0].name ?? "компанія") заявила, що призупиняє або скорочує свою діяльність на росії"
        }
        if decodeStatus[0].status == "out_of_ukraine"{
            self.companyCircle="🟠"
            return "\(decodeStatus[0].name ?? "компанія") не веде бізнес в Україні"
        }
        if decodeStatus[0].status == "publicly_silence"{
            self.companyCircle="🔴"
            return "\(decodeStatus[0].name ?? "компанія") замовчує"
        }
        if decodeStatus[0].status == "russian_collaborator"{
            self.companyCircle="🔴"
            return " \(decodeStatus[0].name ?? "компанія") є колаборантом"
        }
        return ""
    }
}

extension String {
   var isNumeric: Bool {
     return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
   }
}
