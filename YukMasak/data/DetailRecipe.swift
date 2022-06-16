//
//  DetailRecipe.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import Foundation

struct DetailRecipe : Decodable {
    var title: String?
    var thumb: String?
    var servings: String?
    var times: String?
    var dificulty: String?
    var desc: String?
    var author: Author?
    var ingredient: [String] = []
    var step: [String] = []
}

struct Author : Decodable {
    var user: String?
    var datePublished: String?
}
