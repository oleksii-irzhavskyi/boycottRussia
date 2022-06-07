//
//  CompanyListScreen.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 04.06.2022.
//

import SwiftUI

struct CompanyListScreen: View {
    @ObservedObject var fetcher = CompanyListViewModel()
    var body: some View {
        if fetcher.posts.count == 0 {
            if #available(iOS 14.0, *) {
                ProgressView()
            } else {
                // Fallback on earlier versions
            }
        }else{
            if #available(iOS 14.0, *) {
                List(fetcher.posts, children: \.items){ row in
                    if #available(iOS 15.0, *) {
                        AsyncImage(
                            url: URL(string: row.icon!),
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
                .navigationTitle("Expandable Table")
            } else {
                // Fallback on earlier versions
            }
            }
        }
    
}

struct CompanyListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CompanyListScreen()
    }
}
