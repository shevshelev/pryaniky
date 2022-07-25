//
//  UITableView + Extension.swift
//  pryaniky
//
//  Created by Shevshelev Lev on 25.07.2022.
//

import UIKit

extension UITableView {
    func registerCells(_ cells: [UITableViewCell & DataCellProtocol]) {
        cells.forEach { register(type(of: $0), forCellReuseIdentifier: type(of: $0).reuseId) }
    }
}
