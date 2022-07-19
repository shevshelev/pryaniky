//
//  ImageCellViewModel.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import Foundation

class ImageCellViewModel: DataCellViewModelProtocol {
    
    private let imageManager: ImageManagerProtocol = ImageManager.shared
    
    let reuseId: String = "ImageCell"
    let rowHeight: Double = 100
    let text: String?
    let imageData: Data?
    
    required init?(data: ResponseData) {
        guard let data = data.data as? [String: String] else { return nil }
        self.text = data["text"]
        self.imageData = imageManager.fetchImageData(from: data["url"])
    }
}
