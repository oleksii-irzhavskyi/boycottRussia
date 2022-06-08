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
    var body: some View {
        NavigationView{
            if fetcher.posts.count == 0 {
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    // Fallback on earlier versions
                }
            }else{
                if #available(iOS 14.0, *) {
                    List(fetcher.filteredData, children: \.items){ row in
                        if #available(iOS 15.0, *) {
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
                            
                        } else {
                            // Fallback on earlier versions
                        }
                        Text(row.name)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Список компаній")
                    .searchable(text: $searchCompany, placement:
                            .navigationBarDrawer(displayMode: .always), prompt: "Find a company") {
                        if fetcher.filteredData.isEmpty{
                            Text("Maybe Something wrong")
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
                } else {
                    // Fallback on earlier versions
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
