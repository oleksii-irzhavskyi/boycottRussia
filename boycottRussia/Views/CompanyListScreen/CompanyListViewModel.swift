//
//  MainVM.swift
//  boycottRussia
//
//  Created by Oleksii Irzhavskyi on 18.05.2022.
//

import Combine
import Foundation

final class CompanyListViewModel: ObservableObject {
    @Published var filteredData = [Bookmark]()
    @Published var posts = [Bookmark]()
    private var companies = [Record]()
    @Published var diggingIn = Bookmark(name: "Відмовили", icon: "star", items: [])
    @Published var buyingTime = Bookmark(name: "Відтягують час", icon: "timer", items: [])
    @Published var scallingBack = Bookmark(name: "Зменшили масштаби", icon: "hand.thumbsup", items: [])
    @Published var suspension = Bookmark(name: "Призупинили роботу", icon: "hand.thumbsup", items: [])
    @Published var withdrawal = Bookmark(name: "Вийшли з ринку", icon: "hand.thumbsup", items: [])
    
    let url = "https://api.airtable.com/v0/appSkeAxl6nGxM3Kd/Company%20Cards?api_key=keyKzAPkUIFqHdn7V"
    
    init(){
        networking(url: url)
    }
    func networking(url:String){
        guard let urls = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: urls) { (data, response, error) in
            do{
                let tempPosts = try JSONDecoder().self.decode(CompanyList.self, from: data!)
                DispatchQueue.main.async {
                    self.companies.append(contentsOf: tempPosts.records)
                    self.filter(companies: tempPosts.records)
                    if tempPosts.offset != nil {
                        self.networking(url: "\(self.url)&offset=\(tempPosts.offset!)")
                    }
                    else{
                        self.posts.append(self.diggingIn)
                        self.posts.append(self.buyingTime)
                        self.posts.append(self.scallingBack)
                        self.posts.append(self.suspension)
                        self.posts.append(self.withdrawal)
                    }
                }
            }
            catch {
                
            }
        }.resume()
    }
    func filterList(list: [Record], searchCompany: String) -> [Record]{
        let filterList = list.filter{$0.fields.name.contains("\(searchCompany)")}
        return filterList
    }
    func search(searchCompany: String = ""){
        var filteredData = [Bookmark]()
        var diggingIn = Bookmark(name: "Відмовили", icon: "star", items: [])
        var buyingTime = Bookmark(name: "Відтягують час", icon: "timer", items: [])
        var scallingBack = Bookmark(name: "Зменшили масштаби", icon: "hand.thumbsup", items: [])
        var suspension = Bookmark(name: "Призупинили роботу", icon: "hand.thumbsup", items: [])
        var withdrawal = Bookmark(name: "Вийшли з ринку", icon: "hand.thumbsup", items: [])
        let companies = filterList(list: companies, searchCompany: searchCompany)
        if searchCompany.isEmpty{
            self.filteredData = posts
        }else{
            for companie in companies{
                if companie.fields.grade == "Digging In"{
                    diggingIn.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
                }
                if companie.fields.grade == "Buying Time"{
                    buyingTime.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
                }
                if companie.fields.grade == "Scaling Back"{
                    scallingBack.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
                }
                if companie.fields.grade == "Suspension"{
                    suspension.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
                }
                if companie.fields.grade == "Withdrawal"{
                    withdrawal.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
                }
            }
            self.diggingIn = diggingIn
            self.withdrawal = withdrawal
            self.suspension = suspension
            self.scallingBack = scallingBack
            self.buyingTime = buyingTime
            filteredData.append(self.diggingIn)
            filteredData.append(self.buyingTime)
            filteredData.append(self.scallingBack)
            filteredData.append(self.suspension)
            filteredData.append(self.withdrawal)
            self.filteredData=filteredData
        }
        
    }
    func filter(companies: [Record]){
        for companie in companies{
            if companie.fields.grade == "Digging In"{
                self.diggingIn.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
            }
            if companie.fields.grade == "Buying Time"{
                self.buyingTime.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
            }
            if companie.fields.grade == "Scaling Back"{
                self.scallingBack.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
            }
            if companie.fields.grade == "Suspension"{
                self.suspension.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
            }
            if companie.fields.grade == "Withdrawal"{
                self.withdrawal.items?.append(Bookmark(name: companie.fields.name, icon: companie.fields.logo[0].thumbnails.small.url))
            }
        }
    }
}
