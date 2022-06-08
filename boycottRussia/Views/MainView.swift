//
//  TabView.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 07.06.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Main()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Пошук")
                }
            CompanyListScreen()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Список")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
