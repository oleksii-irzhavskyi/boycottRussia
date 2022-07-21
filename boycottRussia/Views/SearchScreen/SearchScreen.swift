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
    @State var submit = false
    
    var body: some View{
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        NavigationView{
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
                
                VStack(alignment: .customCenter){
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
                            if viewModel.ratingHide{
                                HStack{
                                    Button(action: {
                                        print("like")
                                        viewModel.addReaction(reaction: "plus")
                                        submit = true
                                        
                                    }){
                                        Image(systemName: "hand.thumbsup.fill")
                                            .foregroundColor(Color.green)
                                            .font(.system(size: 30))
                                            
                                    }.alert("Дякуємо за ваш голос", isPresented: $submit){
                                        Button("Закрити", role: .cancel){viewModel.ratingHide = false}
                                    }
                                    Button {
                                        print("disslike")
                                        viewModel.addReaction(reaction: "minus")
                                        submit = true
                                    } label: {
                                        Image(systemName: "hand.thumbsdown.fill")
                                            .foregroundColor(Color.red)
                                            .font(.system(size: 30))
                                            
                                        }.alert("Дякуємо за ваш голос", isPresented: $submit){
                                            Button("Закрити", role: .cancel){viewModel.ratingHide = false}
                                    }
                                }
                                Spacer()
                            }

                        }
                    }
                    .frame(width: width/1.2, height: 270)
//                    .frame(width: width/1.2, height: height*0.32)
                    
//                    Spacer(minLength: 20)
                    
//                    Text("t.me/BoycottRussiaBot")
                    HStack{
                        Text(Image("tg"))
                        Link("t.me/BoycottRussiaBot", destination: URL(string: "https://t.me/BoycottRussiaBot")!)
                    }
                    NeumorphicStyleTextField(textField: TextField("Пошук...", text: $viewModel.searchCompany))
                        .frame(width: width/1.2)
                        .onSubmit {
                            viewModel.fetchAPI()
                        }
                        .submitLabel(.done)
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
                        .alignmentGuide(.customCenter) {
                          $0[HorizontalAlignment.center]
                        }
//                        .padding(.horizontal, 30)
//                        .padding(.trailing, -30)
                        .padding(.leading, 30.0)
                        .padding(.vertical, 30)
                        .disabled(!viewModel.isValid)
                        Button {
                            self.isPresentingScanner.toggle()
                        } label: {
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .frame(width: 44, height: 44)
                        }
                        .sheet(isPresented: $isPresentingScanner) {
                            CodeScannerView(codeTypes: [.ean13,
                                                        .ean8,
                                                        .code128], showViewfinder: true) { response in
                                if case let .success(result) = response {
                                    viewModel.searchBarcode = result.string
                                    viewModel.getbarcodeInfo()
                                    isPresentingScanner = false
                                }
                            }
                        }
                    }
                    .frame(width: width/1.2)
//                    .padding(.bottom , 5)
                    if height<800{
                        Spacer(minLength: 80)
                    } else {
                        Spacer(minLength: 100)
                    }
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            }
        }
}
}

struct CustomCenter: AlignmentID {
  static func defaultValue(in context: ViewDimensions) -> CGFloat {
    context[HorizontalAlignment.center]
  }
}
extension HorizontalAlignment {
  static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
