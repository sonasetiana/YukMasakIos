//
//  ProfileView.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image(AppIcon.MyPhoto)
                .resizable()
                .frame(width: 72, height: 72, alignment: .center)
                .clipShape(Circle())
                .padding(.top, AppSpacing.xxxLarge)
            
            VStack(alignment: .leading){
                Text("Sona Setiana")
                    .font(.system(size: 16, weight: .bold))
                    .bold()
                
                ItemProfile(
                    label: "Email",
                    title: "sonasetiana13@gmail.com"
                )
                
                ItemProfile(
                    label: "Nomor Ponsel",
                    title: "081212349846"
                )
                
                ItemProfile(
                    label: "Alamat",
                    title: "Jln. Margonda Raya No. 46, Kec. Beji, Kel. Depok, Kota. Depok, Jawa Barat 16432"
                )
            }
            .frame(width: .infinity)
            .padding()
            
            Spacer()
            
            Image(AppIcon.ImgLogoBig)
                .resizable()
                .frame(
                    width: 100,
                    height: 60
                )
                .padding()
        }
        .edgesIgnoringSafeArea(.top)
        
    }
}

struct ItemProfile: View {
    var label: String
    var title: String
    
    var body : some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.secondary)
                .lineLimit(1)
            Text(title)
                .font(.system(size: 14, weight: .regular))
        }
        .frame(width: .infinity)
        .padding(.top, AppSpacing.normal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

