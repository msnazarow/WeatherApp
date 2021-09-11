//
//  SearchScreenDataSource.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 11.09.2021.
//

import UIKit

class SearchScreenDataSource: NSObject, UITableViewDataSource {
    var sections: [CitySectionModel] = []

    func updateForSections(_ sections: [CitySectionModel]) {
        self.sections = sections
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? WeatherCell {
            cell.model = model
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
