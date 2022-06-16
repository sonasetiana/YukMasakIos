//
//  DetailView.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import SwiftUI

struct DetailView: View {
    var key: String
    var imageUrl: String
    @ObservedObject var controller : DetailController = DetailController()
    var body: some View {
        
        VStack{
            if self.controller.loading {
                Loading()
            } else if !self.controller.errorMessage.isEmpty {
                ErrorView(
                    message: self.controller.errorMessage,
                    onPressed: {
                        self.controller.getDetailRecipe()
                    }
                )
            } else {
                content
            }
        }
        .onAppear(perform: {
            self.controller.key = key
            self.controller.getDetailRecipe()
        })
        .edgesIgnoringSafeArea(.top)
        
    }
}

extension DetailView {
    var content : some View {
        ScrollView(.vertical, showsIndicators: false){
            let recipe = controller.item
            VStack(alignment: .leading){

                NetImage(
                    url: imageUrl,
                    width: .infinity,
                    height: 160
                ).padding(
                    EdgeInsets(
                        top: AppSpacing.xxxLarge,
                        leading: AppSpacing.none,
                        bottom: AppSpacing.normal,
                        trailing: AppSpacing.none
                    )
                )
                
                HStack{
                    IconText(icon: AppIcon.ImgChief, text: recipe?.author?.user ?? "")
                    Spacer()
                    Text(recipe?.author?.datePublished ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(1)
                }
                .frame(width: .infinity)
                .padding(.horizontal, AppSpacing.medium)
                
                Text(recipe?.title?.split(separator: ".")[0] ?? "")
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(2)
                    .padding(.horizontal, AppSpacing.medium)
                
                HStack{
                    Spacer()
                    IconText(icon: AppIcon.ImgTimer, text: recipe?.times ?? "")
                    IconText(icon: AppIcon.ImgPeople, text: recipe?.servings ?? "")
                }
                .frame(width: .infinity)
                .padding(
                    EdgeInsets(
                        top: AppSpacing.none,
                        leading: AppSpacing.medium,
                        bottom: AppSpacing.medium,
                        trailing: AppSpacing.medium
                    )
                )
                
                Divider()
                
                Text(recipe?.desc?.split(separator: ".")[0] ?? "").font(
                    .system(size: 14, weight: .light)
                ).padding(.horizontal, AppSpacing.medium)
                
                Divider()
                
                ListView(
                    title: "Bahan - bahan :",
                    items: recipe?.ingredient ?? []
                )
                
                Divider()
                
                ListView(
                    title: "Cara masak :",
                    items: recipe?.step ?? []
                ).padding(.bottom)
                    
            }
        }
    }
}

struct IconText: View {
    var icon: String
    var text: String
    var icWidth: Double = 16
    var icHeight: Double = 16
    
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .frame(
                    width: icWidth,
                    height: icHeight
                )
            Text(text)
                .font(.caption)
        }
    }
}

struct Divider: View {
    var color: Color = AppColor.LineColor
    var thickness: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: thickness)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct ListView: View {
    var title: String
    var items: [String]
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.system(size: 16, weight: .bold))
            ForEach(0..<items.count){ i in
                ItemList(item: items[i])
            }
        }.padding(.horizontal, AppSpacing.medium)
    }
}

struct ItemList: View {
    var item: String
    var body: some View {
        HStack{
            AppColor.DotColor.frame(width: 5, height: 5).cornerRadius(50)
            Text(item)
                .font(.system(size: 12, weight: .regular))
            
        }
        .frame(width: .infinity)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            key: "resep-coto-makassar",
            imageUrl: "https://www.masakapahariini.com/wp-content/uploads/2019/02/coto-makassar-1-400x240.jpg"
        )
    }
}
