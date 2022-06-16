//
//  NetImage.swift
//  YukMasak
//
//  Created by sona setiana on 16/06/22.
//

import SwiftUI

struct NetImage: View {
    var url: String
    var width: Double = 100
    var height: Double = 100
    @ObservedObject var service = ImageService()
    @State var image : UIImage = UIImage()
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: self.width, height: self.height)
            .onReceive(self.service.$image) { image in
                self.image = image
            }
            .onAppear {
                self.service.load(url: url)
            }
    }
}

class ImageService : ObservableObject {
    @Published var image : UIImage = UIImage()
    
    func load(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: imageUrl){ (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}
