//
//  ErrorView.swift
//  YukMasak
//
//  Created by sona setiana on 17/06/22.
//

import SwiftUI

struct ErrorView: View {
    var message: String?
    let onPressed: () -> Void
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .center, spacing: AppSpacing.medium){
                Text(message ?? "Terjadi kesalahan. Silakan coba lagi nanti.").multilineTextAlignment(.center)
                Button("Coba Lagi"){
                    onPressed()
                }
            }.padding(.all, AppSpacing.medium)
            Spacer()
        }
    }
}
