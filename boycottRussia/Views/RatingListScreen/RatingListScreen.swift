//
//  RatingListScreen.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.07.2022.
//

import SwiftUI

struct RatingListScreen: View {
    @StateObject private var viewModel = RatingListViewModel()
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Georgia-Bold", size: 25)!]
    }
    var body: some View {
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
                List(viewModel.ratings) { rating in
                    HStack{
                        VStack(alignment: .leading){
                            Text(rating.name).font(.title3).bold()
                        }
                        Spacer()
                        VStack{
                            if rating.rating>0{
                                Text("\(rating.rating)")
                                    .font(.title3).bold()
                                    .foregroundColor(Color.green)
                            }else{
                                Text("\(rating.rating)")
                                    .font(.title3).bold()
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                }.listStyle(SidebarListStyle())
                    .refreshable {
                        viewModel.listenRealtimeDatabase()
                    }
                //            .onAppear{
                //                viewModel.listenRealtimeDatabase()
                //            }
                //            .onDisappear{
                //                viewModel.stopListening()
                //            }
            }.navigationTitle(Text("Рейтинг від користувачів").font(.subheadline))
        }
    }
}

struct RatingListScreen_Previews: PreviewProvider {
    static var previews: some View {
        RatingListScreen()
    }
}
