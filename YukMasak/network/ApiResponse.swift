//
//  BaseResponse.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import Foundation
import UIKit

struct ListResponse<T : Decodable>: Decodable {
    var method: String?
    var status: Bool?
    var results: [T]?
}

struct ObjectResponse<T : Decodable>: Decodable {
    var method: String?
    var status: Bool?
    var results: T?
}
