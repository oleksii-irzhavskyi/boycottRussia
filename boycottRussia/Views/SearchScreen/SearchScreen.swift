//
//  Main.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.05.2022.
//

import SwiftUI
import Combine
import CodeScanner

struct Home: View {
    @StateObject private var viewModel = SearchScreenViewModel()
    @State private var isPresentingScanner = false
    
    var body: some View{
        let width = UIScreen.main.bounds.width
        NavigationView {
            ZStack{
                LinearGradient(colors: [Color.blue,Color.yellow
                                       ], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                GeometryReader{ proxy in
                    let size = proxy.size
                    
                    Color.blue
                        .opacity(0.7)
                        .blur(radius: 200)
                        .ignoresSafeArea()
                    Circle()
                        .fill(Color.purple)
                        .padding(50)
                        .blur(radius: 120)
                        .offset(x: -size.width/1.8, y: -size.height/5)
                    Circle()
                        .fill(Color.white)
                        .padding(50)
                        .blur(radius: 150)
                        .offset(x: size.width/1.8, y: -size.height/2)
                    Circle()
                        .fill(Color.white)
                        .padding(50)
                        .blur(radius: 90)
                        .offset(x: size.width/1.8, y: size.height/2)
                    Circle()
                        .fill(Color.purple)
                        .padding(100)
                        .blur(radius: 110)
                        .offset(x: size.width/1.8, y: size.height/2)
                    Circle()
                        .fill(Color.purple)
                        .padding(100)
                        .blur(radius: 110)
                        .offset(x: -size.width/1.8, y: size.height/2)
                    
                    
                }
                
                VStack{
                    Text("Boycott r*ssia")
                        .font(.system(size: 40, weight: .bold))
                    
                    Spacer(minLength: 10)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .opacity(0.2)
                            .background(
                                
                                Color.white
                                    .opacity(0.08)
                                    .blur(radius: 10)
                                
                            )
                            .background(
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(
                                        
                                        .linearGradient(.init(colors: [
                                            
                                            Color.blue,
                                            Color.blue.opacity(0.5),
                                            .clear,
                                            .clear,
                                            Color.yellow,
                                        ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        ,lineWidth: 2.5
                                    )
                                    .padding(2)
                            )
                        //Shadows
                            .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                        //Content
                        VStack{
                            Text(viewModel.companyCircle)
                                .font(.system(size: 60, weight: .thin))
                                .padding(.top)
                            Spacer()
                            Text(viewModel.companyStatus)
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .frame(width: width/1.5)
                            Spacer(minLength: 10)
                        }
                    }
                    .frame(width: width/1.2, height: 270)
                    
                    Spacer(minLength: 20)
                    
                    Text("Не підтримуй окупанта")
                        .padding(.top)
                    TextField("Введіть назву товару", text: $viewModel.searchCompany)
                        .foregroundColor(Color.black)
                        .padding(.trailing)
                        .frame(alignment: .center)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    HStack {
                        Button {
                            viewModel.fetchAPI()
                        } label: {
                            Text("Пошук")
                                .font(.title3.bold())
                                .padding(.vertical ,22)
                                .frame(maxWidth: .infinity)
                                .background(
                                    
                                    .linearGradient(.init(colors: [
                                        
                                        Color.blue,
                                        Color.yellow
                                    ]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    
                                    ,in: RoundedRectangle(cornerRadius: 20)
                                )
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 20)
                        .disabled(!viewModel.isValid)
                        Button {
                            self.isPresentingScanner.toggle()
                        } label: {
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .frame(width: 30, height: 30)
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
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            }
        }
    }
}
