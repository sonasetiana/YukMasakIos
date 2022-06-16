//
//  Recipe.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import Foundation

struct Recipe : Decodable {
    var title: String?
    var thumb: String?
    var key: String?
    var times: String?
    var portion: String?
    var dificulty: String?
}
