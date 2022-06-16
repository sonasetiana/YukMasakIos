//
//  EmptyView.swift
//  YukMasak
//
//  Created by sona setiana on 17/06/22.
//

import SwiftUI

struct EmptyView: View {
    var message : String = "Data kosong"
    var body: some View {
        VStack{
            Spacer()
            Text(message).multilineTextAlignment(.center)
            Spacer()
        }.padding(.all, AppSpacing.medium)
    }
}
