//
//  boycottRussiaApp.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 04.05.2022.
//

import SwiftUI
import FirebaseCore
import Firebase
import Siren

@main
struct BoycottRussiaApp: App {
    init() {
            FirebaseApp.configure()
        hyperCriticalRulesExample()
        }
    var body: some Scene {
        WindowGroup {
            CustomTabBar()
        }
    }
    func hyperCriticalRulesExample() {
        let siren = Siren.shared
        siren.rulesManager = RulesManager(globalRules: .annoying)
        siren.presentationManager = PresentationManager(forceLanguageLocalization: .ukrainian)

        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
