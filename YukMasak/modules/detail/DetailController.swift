//
//  DetailController.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import Foundation

class DetailController : ObservableObject {
    @Published var key: String = ""
    @Published var loading: Bool = false
    @Published var errorMessage: String = ""
    @Published var item: DetailRecipe?
    
    func getDetailRecipe() {
        loading = true
        errorMessage = ""
        ApiEngine.objectRequest(
            endPoint: "api/recipe/"+key,
            resultType: DetailRecipe(),
            onSuccess: { response in
                self.loading = false
                self.item = response.results
            }, onError: { message in
                self.loading = false
                self.errorMessage = message
            }
        )
    }
}
