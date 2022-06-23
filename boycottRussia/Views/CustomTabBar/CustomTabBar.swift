//
//  CustomTabBar.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 23.06.2022.
//

import SwiftUI

struct CustomTabBar: View {
    @StateObject var tabData = TabViewModel()
    //Hiden tabbar
    init(){
        UITabBar.appearance().isHidden = true
        UITabBar.appearance().backgroundColor = .darkText
    }
    
    @Namespace var animation
    let width = UIScreen.main.bounds.width
    var body: some View {
        
        TabView(selection: $tabData.currentTab) {
            
            Home()
                .tag("Пошук")
            CompanyListScreen()
                .tag("Список")
        }
        .overlay(
            HStack{
                TabBarButton(title: "Пошук", image: "magnifyingglass", animation: animation)
                TabBarButton(title: "Список", image: "list.bullet", animation: animation)
            }
            .environmentObject(tabData)
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .opacity(0.2)
                    .background(
                        
                        Color.white
                            .opacity(0.08)
                            .blur(radius: 10)
                        
                    ))
//                .background(
//
//                    Color.white
//                        .opacity(0.08)
//                        .blur(radius: 10)
//
//                )
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
                            ,lineWidth: 1.5
                        )
//                        .padding(2)
                )
                .frame(width: width/1.2)
                .padding(.bottom, 8)
            //shadow
                .shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.09), radius: 5, x: -5, y: 0)
            ,alignment: .bottom
        )
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

//tabbarbutton
struct TabBarButton: View{
    
    var title: String
    var image: String
    //slide anim
    var animation: Namespace.ID
    @EnvironmentObject var tabData: TabViewModel
    var body: some View{
        
        Button {
            withAnimation{
                tabData.currentTab = title
            }
            
        } label: {
            VStack{
                Image(systemName: image)
                    .font(.title2)
                
                Text(title)
                    .font(.caption.bold())
            }
            .foregroundColor(tabData.currentTab == title ? .blue : Color.golden)
            .frame(maxWidth: .infinity)
            
        }
    }
}


// Custom Tab lighting indicator
//shape

