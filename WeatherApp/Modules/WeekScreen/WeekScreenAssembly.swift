//
//  WeekScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum WeekScreenAssembly {
    static func createWeekScreen(for cityId: Int, isWeekMode: Bool) -> WeekScreenViewController {
        let viewController = WeekScreenViewController(style: .grouped)
        let router = WeekScreenRouter(view: viewController)
        let presenter = WeekScreenPresenter(router: router, cityId: cityId, isWeekMode: isWeekMode)
        let interactor = WeekScreenInteractor()

        presenter.interactor = interactor
        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
