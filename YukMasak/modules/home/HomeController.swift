//
//  HomeController.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import Foundation

class HomeController : ObservableObject{
    
    @Published var loading: Bool = false
    @Published var loadingMore: Bool = false
    @Published var errorMessage: String = ""
    @Published var items: [Recipe] = []
    @Published var nextPage: Int = 0
    private var workItemRef : DispatchWorkItem? = nil
    @Published var keyword = "" {
            didSet {
                workItemRef?.cancel()
                let workItem = DispatchWorkItem
                {
                    if !self.keyword.isEmpty {
                        self.searchRecipe()
                    }else {
                        self.nextPage = 0
                        self.getRecipes()
                    }
                }
                workItemRef = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
            }
        }
    
    func getRecipes() {
        loading = true
        errorMessage = ""
        ApiEngine.listRequest(
            endPoint: "api/recipes/\(nextPage)",
            resultType: Recipe(),
            onSuccess: { response in
                self.loading = false
                self.items = response.results ?? []
                if !self.items.isEmpty {
                    self.nextPage += 1
                }
            }, onError: { message in
                self.loading = false
                self.errorMessage = message
            }
        )
    }
    
    func getMoreRecipes() {
        loadingMore = true
        ApiEngine.listRequest(
            endPoint: "api/recipes/\(nextPage)",
            resultType: Recipe(),
            onSuccess: { response in
                self.loadingMore = false
                let result = response.results ?? []
                if !result.isEmpty {
                    self.items += result
                    self.nextPage += 1
                }
            }, onError: { message in
                self.loadingMore = false
            }
        )
    }
    
    func searchRecipe() {
        loading = true
        errorMessage = ""
        ApiEngine.listRequest(
            endPoint: "api/search/?q=\(keyword)",
            resultType: Recipe(),
            onSuccess: { response in
                self.loading = false
                self.items = response.results ?? []
            }, onError: { message in
                self.loading = false
                self.errorMessage = message
            }
        )
    }
    
}
