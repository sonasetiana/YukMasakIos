//
//  RecipeView.swift
//  YukMasak
//
//  Created by sona setiana on 17/06/22.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    var body: some View {
        NavigationLink(
            destination: DetailView(
                key: recipe.key ?? "",
                imageUrl: recipe.thumb ?? ""
            )
        ){
            ZStack {
                RoundedRectangle(cornerRadius: AppSpacing.normal)
                    .foregroundColor(.white)
                    .frame(height: 160)
                VStack(alignment: .leading){
                    itemImage
                    itemTitle
                        .padding(.horizontal)
                    itemPortion
                        .padding(.horizontal)
                }
            }
        }
    }
}

extension RecipeView {
    var itemImage : some View {
        ZStack(alignment: .topLeading) {
            
            NetImage(
                url: recipe.thumb ?? "",
                width: .infinity,
                height: .infinity
            ).cornerRadius(6, corners: [.topRight, .topLeft])
            
            HStack{
                Image(AppIcon.ImgTimer)
                    .resizable()
                    .frame(width: 12, height: 12)
                Text(recipe.times ?? "")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(AppColor.PinkColor)
                    .padding(.leading, AppSpacing.tiny)
                    
            }
            .padding(EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10))
            .background(.white)
            .cornerRadius(12, corners: [.bottomRight])
            .padding(.top)
            
        }
        .frame(width: .infinity, height: 120)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0))
            
    }
    
    var itemTitle : some View {
        Text(recipe.title?.split(separator: ".")[0] ?? "")
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(.black)
            .lineLimit(2)
    }
    
    var itemPortion : some View {
        HStack{
            Spacer()
            Image(AppIcon.ImgPeople)
                .resizable()
                .frame(width: 12, height: 12)
            Text(recipe.portion ?? "")
                .font(.system(size: 10, weight: .regular))
                .foregroundColor(.black)
                .padding(.leading, AppSpacing.tiny)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
