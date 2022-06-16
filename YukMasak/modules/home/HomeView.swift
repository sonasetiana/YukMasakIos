//
//  HomeView.swift
//  YukMasak
//
//  Created by sona setiana on 15/06/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var controller : HomeController = HomeController()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    header
                    searchBar
                }.padding(.bottom, 16)
                    .padding(.top)
                
                if self.controller.loading {
                    Loading()
                } else if !self.controller.errorMessage.isEmpty{
                    ErrorView(
                        message: self.controller.errorMessage,
                        onPressed: {
                            if self.controller.keyword.isEmpty {
                                self.controller.getRecipes()
                            }else  {
                                self.controller.searchRecipe()
                            }
                        }
                    )
                } else {
                    let items = self.controller.items
                    
                    if items.isEmpty {
                        EmptyView()
                    }else {
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ],
                                spacing: AppSpacing.normal
                            ){
                                ForEach(0..<items.count+1){ i in
                                    if i == items.count {
                                        ProgressView().progressViewStyle(CircularProgressViewStyle()).foregroundColor(.black).opacity(self.controller.loadingMore ? 1 : 0)
                                    }
                                    if i < items.count{
                                        RecipeView(
                                            recipe: items[i]
                                        ).onAppear{
                                            if i == items.count - 2 {
                                                self.controller.getMoreRecipes()
                                            }
                                        }
                                    }
                                }
                            }.padding(.trailing, 8)
                        }
                    }
                }
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            .onAppear(perform: {
                self.controller.getRecipes()
            })
            
        }
        
        
    }
}

extension HomeView {
    var header : some View {
        HStack{
            Image(AppIcon.ImgLogo)
                .frame(alignment: .trailing)
            Spacer()
            NavigationLink(destination: ProfileView()){
                Image(AppIcon.ImgProfile)
                    .resizable()
                    .frame(
                        width: 24,
                        height: 24,
                        alignment: .leading
                    )
            }
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            alignment: .topLeading
        ).padding(.all)
    }
    
    var searchBar : some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(
                    "Cari Masakkan Anda",
                    text: $controller.keyword
                ).foregroundColor(.primary)
                Button(
                    action : {
                        self.controller.keyword = ""
                    }
                ){
                    Image(systemName: "xmark.circle.fill")
                        .opacity(controller.keyword == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool){
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.endEditing(force)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
