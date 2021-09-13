//
//  MainForecastScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MainForecastScreenAssembly {
    static func createMainForecastScreen(for cityId: Int, cityName: String) -> UIViewController {
        let viewController = MainForecastScreenViewController()
        let router = MainForecastScreenRouter(view: viewController)
        let dataSource = MainForecastScreenDataSource()
        // TODO: - Используется класс из другого модуля
        let settingsStorageService = SettingsStorageService()
        let presenter = MainForecastScreenPresenter(router: router,
                                                    cityId: cityId,
                                                    cityName: cityName,
                                                    dataSource: dataSource,
                                                    settingsStorageService: settingsStorageService)

        let weatherService = WeatherService()
        let storageService = ImageStorageService()
        let interactor = MainForecastScreenInteractor(weatherService: weatherService, storageService: storageService)

        presenter.interactor = interactor
        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController
        dataSource.presenter = presenter

        return viewController
    }
}
