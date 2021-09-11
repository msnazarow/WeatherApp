//
//  DayScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

protocol DayScreenViewInput: class {
    func setCityLabel(city: String)
    func setWeatherLabel(weather: String)
    func setDegreeLabel(degree: Int)
    func setMinMaxDegreeLabel(min: Int, max: Int)
    func setDescriptionTable(day: WeatherDayResponse)
    func update()
}

class DayScreenViewController: UITableViewController {
    var presenter: DayScreenViewOutput?
    let vStack = DaySummaryStackView()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.autoresizesSubviews = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let header = tableView.tableHeaderView {
            header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height
        }
    }

    func setUI() {
        tableView.sectionHeaderHeight = 174 * verticalTranslation
        tableView.backgroundColor = .white
        tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.tableHeaderView = vStack
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 16 * verticalTranslation)]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
}

extension DayScreenViewController: DayScreenViewInput {
    func setCityLabel(city: String) {
        vStack.cityLabel.text = city
    }

    func setWeatherLabel(weather: String) {
        vStack.weatherLabel.text = weather
    }

    func setDegreeLabel(degree: Int) {
        vStack.degreeLabel.text = "\(degree)°"
    }

    func setMinMaxDegreeLabel(min: Int, max: Int) {
        vStack.minMaxLabel.text = "Макс. \(min)°, мин. \(max)°"
    }

    func update() {
        tableView.reloadData()
    }

    @objc func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }

    func setDescriptionTable(day: WeatherDayResponse) {
        var sections: [DescriptionSectionModel] = []
        var models: [DescriptionPropertyModel] = []
        models.append(DescriptionPropertyModel(title: "Направление Ветра", description: day.windDirectionCompass))
        models.append(DescriptionPropertyModel(title: "Ветер", description: "\(String(format: "%.1f", day.windSpeed)) м/с"))
        if let humidity = day.humidity {
            models.append(DescriptionPropertyModel(title: "Влажность", description: "\(humidity) %"))
        }
        if let airPressure = day.airPressure {
            models.append(DescriptionPropertyModel(title: "Давление", description: "\(Int(airPressure)) мм рт.cт"))
        }
        if let visibility = day.visibility {
            models.append(DescriptionPropertyModel(title: "Видимость", description: "\(String(format: "%.2f", visibility)) км"))
        }
        sections.append(DescriptionSectionModel(models))
    }
}
