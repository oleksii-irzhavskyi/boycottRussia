//
//  SuggestionScreen.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 12.07.2022.
//

import SwiftUI

struct SuggestionScreen: View {
    @StateObject private var viewModel = SuggestionScreenViewModel()
    @State var submit = false
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height
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
            ZStack{
                VStack{
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
                            Text("Введіть інформацію якою ви б хотіли поділитись з нами.")
                                .font(.title3)
                                .foregroundColor(Color.white)
                                .frame(width: width/1.5)
                                .padding()
                        }
                    }.frame(width: width/1.1, height: 135)
                    
                    Form{
                        Section(header: Text("Назва компанії або товару (обов'язково)")){
                            TextField("Введіть назву компанії", text: $viewModel.companyName)
                        }.foregroundColor(.black)
                        Section(header: Text("Інформація яка є у вас (обов'язково)")){
                            TextField("Введіть назву компанії", text: $viewModel.infoAboutCompany)
                        }.foregroundColor(.black)
                        Section(header: Text("Посилання на підтвердження")){
                            TextField("Введіть назву компанії", text: $viewModel.link)
                        }.foregroundColor(.black)
                        Button(action:{
                            viewModel.test()
                            submit = true
                        }){
                            Text("Відправити")
                        }.disabled(!viewModel.formIsValid)
                            .alert("Дякуємо за допопмогу", isPresented: $submit){
                            Button("Закрити", role: .cancel){}
                        }
                    }.padding(.bottom , 20)
                }.background(Color.clear)
            }
        }
    }
}

struct SuggestionScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionScreen()
    }
}
