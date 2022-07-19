//
//  ImageManager.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 19.07.2022.
//

import Foundation

protocol ImageManagerProtocol {
    func fetchImageData(from url: String?) -> Data?
}

class ImageManager: ImageManagerProtocol {
    
    static let shared: ImageManagerProtocol = ImageManager()
    
    private init () {}
    
    func fetchImageData(from urlString: String?) -> Data? {
        guard let url = URL(string: urlString ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData

    }
}
