//
//  TabView.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 07.06.2022.
//

import SwiftUI

struct MainView: View {
    let width = UIScreen.main.bounds.width
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Пошук")
                        .foregroundColor(Color.blue)
                }
            CompanyListScreen()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Список")
                        .foregroundColor(Color.black)
                }
        }
    }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
