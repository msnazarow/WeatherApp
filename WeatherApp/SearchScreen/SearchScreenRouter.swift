//
//  SearchScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchScreenRouterInput {
    func routeToWeekScreen(cityId: Int)
}

class SearchScreenRouter: SearchScreenRouterInput {
    weak var view: SearchScreenViewController?
    init(view: SearchScreenViewController?) {
        self.view = view
    }

    func routeToWeekScreen(cityId: Int) {
        guard let view = view?.viewController.navigationController else { return }
        let weekScreen = WeekScreenAssembly.createWeekScreen()
        weekScreen.loadForCity(cityId: cityId)
            view.pushViewController(weekScreen, animated: true)
            // TODO: - Хз будут ли лики
            view.setViewControllers([view.viewControllers[0], view.viewControllers[2]], animated: false)
    }
}
