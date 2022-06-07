//
//  Main.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.05.2022.
//

import SwiftUI
import Combine
import CodeScanner

struct Main: View {
    @StateObject private var viewModel = SearchScreenViewModel()
    @State private var isPresentingScanner = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.topColor,.centerColor]),
                           startPoint: .topLeading,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 140){
                Text("boycottRussia")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 50))
                .frame(alignment: .topLeading)
                HStack {
                    TextField("Введіть назву товару", text: $viewModel.searchCompany)
                        .frame(alignment:.center)
//                        .fixedSize()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Button(action: {
                        viewModel.fetchAPI()
                    }) {
                        Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    }.disabled(!viewModel.isValid)
                    Button(action: {
                        self.isPresentingScanner.toggle()
                    }){
                        Image(systemName: "barcode")
                    }
                    .sheet(isPresented: $isPresentingScanner) {
                        CodeScannerView(codeTypes: [.qr]) { response in
                            if case let .success(result) = response {
                                viewModel.searchBarcode = result.string
                                viewModel.getbarcodeInfo()
                                isPresentingScanner = false
                            }
                        }
                    }
                }
                Text(viewModel.companyStatus)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding(.top, 150.0)
        }
//            .onAppear {
//                viewModel.fetchAPI()
//            }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
