//
//  CompanyListScreen.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 04.06.2022.
//

import SwiftUI

struct CompanyListScreen: View {
    @ObservedObject var fetcher = CompanyListViewModel()
    @State private var searchCompany = ""
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
        
    }
    var body: some View {
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
                if fetcher.posts.count == 0 {
                    ProgressView("Оновлення списку...")
                } else {
                    List(fetcher.filteredData, children: \.items) { row in
                        AsyncImage(
                            url: URL(string: row.icon ?? "https://www.meme-arsenal.com/memes/15ef8d1ccbb4514e0a758c61e1623b2f.jpg"),
                            transaction: Transaction(animation: .easeInOut)
                        ) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .transition(.scale(scale: 0.1, anchor: .center))
                            case .failure:
                                Image(systemName: "wifi.slash")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 50, height: 36)
                        .background(Color.white)
                        VStack{
                            Text(row.name)
                            //                                .font(.headline)
                            //                                .font(.title3)
                            //                                Text(row.country ?? "")
                            //                                .font(.subheadline)
                        }
                        Spacer()
                        
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Список компаній")
                    .searchable(text: $searchCompany, placement:
                            .navigationBarDrawer(displayMode: .always), prompt: "Введіть назву компанії"){
                                if fetcher.filteredData.isEmpty {
                                    Text("Нажаль збігів не виявлено")
                                }
                            }
                            .onSubmit(of: .search) {
                                fetcher.search(searchCompany: searchCompany)
                            }
                            .onChange(of: searchCompany) { newQuery in
                                fetcher.search(searchCompany: newQuery)
                            }
                            .onAppear {
                                fetcher.search()
                            }
                }
            }
            
        }
    }
}

struct CompanyListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CompanyListScreen()
    }
}
