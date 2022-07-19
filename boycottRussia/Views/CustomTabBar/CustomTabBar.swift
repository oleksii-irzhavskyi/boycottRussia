//
//  CustomTabBar.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 23.06.2022.
//

import SwiftUI

struct CustomTabBar: View {
    @State var tabData = "Пошук"
    //Hiden tabbar
    init(){
        UITabBar.appearance().isHidden = true
        UITabBar.appearance().backgroundColor = .darkText
    }
    
    @Namespace var animation
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var body: some View {
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
                TabView(selection: $tabData) {
                    Home()
                        .tag("Пошук")
                    CompanyListScreen()
                        .tag("Список")
                    SuggestionScreen()
                        .tag("Поділитись")
                    RatingListScreen()
                        .tag("Рейтинг")
                }
//                            .overlay(
                HStack{
                    TabBarButton(title: "Пошук", image: "magnifyingglass", animation: animation, tabData: $tabData)
                    TabBarButton(title: "Список", image: "list.bullet", animation: animation, tabData: $tabData)
                    TabBarButton(title: "Рейтинг", image: "star.fill", animation: animation, tabData: $tabData)
                    TabBarButton(title: "Поділитись", image: "plus.circle.fill", animation: animation, tabData: $tabData)
                }
//                .background(RoundedRectangle(cornerRadius: 25)
//                    .fill(.white)
//                    .opacity(0.2)
//                    .background(
//
//                        Color.white
//                            .opacity(0.08)
//                            .blur(radius: 10)
//
//                    ))
//                .background(
//
//                    RoundedRectangle(cornerRadius: 25)
//                        .stroke(
//
//                            .linearGradient(.init(colors: [
//
//                                Color.blue,
//                                Color.blue.opacity(0.5),
//                                .clear,
//                                .clear,
//                                Color.yellow,
//                            ]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                            ,lineWidth: 1.5
//                        )
//                    //                        .padding(2)
//                )
//                .frame(width: width/1.2)
                .padding(.top, 8.0)
                .padding(.bottom, 6.0)                //shadow
                .shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.09), radius: 5, x: -5, y: 0)
//                                ,alignment: .bottom
//                            )
            }
        }
    }
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

//tabbarbutton
struct colortry2: View{
    var body: some View {
        Text("Hello, World!").ignoresSafeArea()
    }
}
struct TabBarButton: View{
    
    var title: String
    var image: String
    //slide anim
    var animation: Namespace.ID
    @Binding var tabData: String
    //    @EnvironmentObject var tabData: TabViewModel
    var body: some View{
        
        Button {
            withAnimation{
                tabData = title
            }
            
        } label: {
            VStack{
                Image(systemName: image)
                    .font(.title2)
                
                Text(title)
                    .font(.caption.bold())
            }
            .foregroundColor(tabData == title ? .blue : Color.white.opacity(0.75))
            .frame(maxWidth: .infinity)
            
        }
    }
}


// Custom Tab lighting indicator
//shape

