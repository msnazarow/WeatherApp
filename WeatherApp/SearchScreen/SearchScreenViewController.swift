//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchScreenViewInput: class {
  var viewController: UIViewController { get }
  var presenter: SearchScreenViewOutput? { get set }
  func updateForSections(_ sections: [CitySectionModel])
}

class SearchScreenViewController: UIViewController {
  var presenter: SearchScreenViewOutput?
  var viewController: UIViewController { return self }
  let searchTextField: SearchTextField = {
    let textField = SearchTextField()
    textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEndOnExit)
    return textField
  }()
  let citiesTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
    return tableView
  }()
  var sections: [CitySectionModel] = []
  override func loadView() {
    super.loadView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    citiesTableView.delegate = self
    citiesTableView.dataSource = self
  }

  func setupUI() {
    title = "Поиск города"
    view.addSubview(searchTextField)
    view.addSubview(citiesTableView)
    view.backgroundColor = .white
//    searchTextField.backgroundColor = .white
//
//    let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass")!)
//    searchTextField.leftView = imageView
//    searchTextField.leftViewMode = .always

    searchTextField.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.right.equalTo(view.safeAreaLayoutGuide).inset(20)
      make.height.equalTo(40)
    }
    citiesTableView.snp.makeConstraints { make in
      make.top.equalTo(searchTextField.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  @objc func editingDidEnd() {
    if let presenter = presenter, let text = searchTextField.text {
      presenter.searchForCity(city: text)
    }
  }
}

extension SearchScreenViewController: SearchScreenViewInput {
  func updateForSections(_ sections: [CitySectionModel]) {
    self.sections = sections
    citiesTableView.reloadData()
  }
}

extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let presenter = presenter else {
      return
    }
    return presenter.tableViewDidSelect(row: indexPath.row)
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sections[indexPath.section].rows[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as! WeatherCell
    cell.model = model
    return cell
  }
}
