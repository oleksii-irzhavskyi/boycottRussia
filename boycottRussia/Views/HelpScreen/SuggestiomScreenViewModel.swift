//
//  SuggestiomScreenViewModel.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 17.07.2022.
//

import Foundation
import Combine

class SuggestionScreenViewModel: ObservableObject {
    @Published var companyName = ""
    @Published var infoAboutCompany = ""
    @Published var link = ""
    
    @Published var formIsValid = false
    
    private var publishers = Set<AnyCancellable>()
    
    init(){
        isSuggestionFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
    }
    
    var isCompanyNameValidPublisher: AnyPublisher<Bool, Never> {
          $companyName
              .map { companyName in
                  return companyName.count >= 2
              }
              .eraseToAnyPublisher()
      }
    
    var isInfoAboutCompanyValidPublisher: AnyPublisher<Bool, Never> {
          $infoAboutCompany
              .map { companyName in
                  return companyName.count >= 2
              }
              .eraseToAnyPublisher()
      }
    
    var isSuggestionFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isCompanyNameValidPublisher,
            isInfoAboutCompanyValidPublisher)
            .map { isCompanyNameValid, isInfoAboutCompanyValid in
                return isCompanyNameValid && isInfoAboutCompanyValid
            }
            .eraseToAnyPublisher()
      }
    
    func test() {
        let object: [String: Any] = [
            "companyName": companyName,
            "infoAboutCompany": infoAboutCompany,
            "link": link
        ]
        FirebaseManager.shared.addNewSuggestion(object: object)
    }
}
