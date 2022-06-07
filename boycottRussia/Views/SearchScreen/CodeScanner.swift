
//  ContentView.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 04.05.2022.


import SwiftUI
import CodeScanner

struct CodeScanner: View {
//    @StateObject
    @State var isPresentingScanner = false
    @State var scannedCode: String = "Scan a QR or barcode to get started."

    var scanerSheet : some View {
        CodeScannerView(codeTypes: [.qr,
                                    .code128,
                                    .code39,
                                    .code39Mod43,
                                    .code93,
                                    .ean13,
                                    .ean8,
                                    .interleaved2of5,
                                    .itf14,
                                    .pdf417,
                                    .upce], scanMode: .once, simulatedData: "I am rusofob") { response in
            switch response {
            case .success(let result):
                print("Found code: \(result.string)")

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//            completion: { result in
//                if case let .success(code) = result {
//                    self.scannedCode = "\(code)"
//                    self.isPresentingScanner = false
//                }
//            }
//        )
    }

    var body: some View {
        VStack(spacing: 10) {
            Text(scannedCode)

            Button("Scan QR code") {
                self.isPresentingScanner = true
            }

            .sheet(isPresented: $isPresentingScanner) {
                self.scanerSheet
            }
        }
}

struct CodeScanner_Previews: PreviewProvider {
    static var previews: some View {
        CodeScanner()
    }
}
}

//import CodeScanner
//import SwiftUI
//
//class Prospect: Identifiable, Codable {
//    var id = UUID()
//    var name = "Anonymous"
//    var emailAddress = ""
//    fileprivate(set) var isContacted = false
//}
//
//@MainActor class Prospects: ObservableObject {
//    @Published private(set) var people: [Prospect]
//    let saveKey = "SavedData"
//
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//
//        // no saved data!
//        people = []
//    }
//
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
//
//    func add(_ prospect: Prospect) {
//        people.append(prospect)
//        save()
//    }
//
//    func toggle(_ prospect: Prospect) {
//        objectWillChange.send()
//        prospect.isContacted.toggle()
//        save()
//    }
//}
//
//struct ContentView: View {
//    @State private var isShowingScanner = false
//
//    @EnvironmentObject var prospects: Prospects
//
//    var body: some View {
//        Button(action: {
//            self.isShowingScanner = true
//        }) {
//            Text("Show Scanner")
//        }
//        .sheet(isPresented: $isShowingScanner) {
//            CodeScannerView(codeTypes: [.ean13], simulatedData: "Some simulated data", completion: handleScan)
//        }
//    }
//
//    func handleScan(result: Result<ScanResult, ScanError>) {
//        isShowingScanner = false
//
//        switch result {
//        case .success(let result):
//            let details = result.string.components(separatedBy: "\n")
//            guard details.count == 2 else { return }
//
//            let person = Prospect()
//            person.name = details[0]
//            person.emailAddress = details[1]
//            prospects.add(person)
//        case .failure(let error):
//            print("Scanning failed: \(error.localizedDescription)")
//        }
//    }
//}
