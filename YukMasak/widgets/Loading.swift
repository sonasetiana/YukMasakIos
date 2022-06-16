//
//  Loading.swift
//  YukMasak
//
//  Created by sona setiana on 17/06/22.
//

import SwiftUI

struct CircularLoading: View {
    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle()).foregroundColor(.black)
    }
}

struct Loading: View {
    var body: some View {
        VStack {
            Spacer()
            CircularLoading()
            Spacer()
        }
    }
}
