//
//  Main.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.05.2022.
//

import SwiftUI
import Combine

struct Main: View {
    @StateObject private var viewModel = MainVM()
    @State var inputText: String = ""
    @State var infoAboutCompany = ""
    
    
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
                HStack {
                    TextField("Введіть назву товару", text: $inputText)
                        .frame(alignment:.center)
//                        .fixedSize()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Button(action: {
                        viewModel.searchCompany = inputText
                        viewModel.fetchAPI()
                    }) {
                        Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    }
                }
                Text(viewModel.companyStatus)
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 40))
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
