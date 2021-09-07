//
//  CellsProtocols.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

protocol CellIdentifiable {
    var cellIdentifier: String { get }
    var cellHeight: Float { get }
}

protocol ModelRepresentable {
    var model: CellIdentifiable? { get set }
}

protocol SectionRowsRepresentable {
    var rows: [CellIdentifiable] { get set }
}
