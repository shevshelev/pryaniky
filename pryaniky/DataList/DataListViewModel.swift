//
//  DataListViewModel.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 18.07.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol DataListViewModelProtocol {
    var views: [ResponseData.DataType] { get }
    var data: [ResponseData] { get }
    func fetchData(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellViewModel(dataType: ResponseData.DataType) -> DataCellViewModelProtocol?
}

class DataListViewModel: DataListViewModelProtocol {
    
    private let networkManager: NetworkManagerProtocol = NetworkManager.shared
    
    var data: [ResponseData] = []
    var views: [ResponseData.DataType] = []
    
    func fetchData(completion: @escaping () -> Void) {
        networkManager.fetchData { [unowned self] result in
            switch result {
            case .success(let result):
                self.data = result.data
                self.views = result.view
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows() -> Int {
        views.count
    }
    
    func cellViewModel(dataType: ResponseData.DataType) -> DataCellViewModelProtocol? {
        switch dataType {
        case .label:
            guard let data = self.data.filter({ $0.type == .label }).first else { return nil }
            return LabelCellViewModel(data: data)
        case .picture:
            guard let data = self.data.filter({ $0.type == .picture }).first else { return nil }
            return ImageCellViewModel(data: data)
        case .selector:
            guard let data = self.data.filter({ $0.type == .selector }).first else { return nil }
            return SelectorCellViewModel(data: data)
        }
    }
}
