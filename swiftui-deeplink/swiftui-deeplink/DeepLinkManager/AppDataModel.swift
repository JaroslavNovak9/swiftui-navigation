//
//  AppDataModel.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import Foundation

final class DeepLinkManager: ObservableObject {

    @Published var currentTab: Tab = .home
    @Published var currentInternalScreen: InternalScreens?

    func evaluateDeepLink(url: URL) -> Bool {
        guard let host = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        )?.host else {
            return false
        }

        // Updating tabs
        if host == Tab.home.rawValue {
            currentTab = .home
        }
        else if host == Tab.list.rawValue {
            currentTab = .list
        }
        else {
            return evaluateInternalLinks(with: url, host: host)
        }

        return true
    }

    private func evaluateInternalLinks(with url: URL, host: String?) -> Bool {
        guard
            let internalHost = URLComponents(
                url: url,
                resolvingAgainstBaseURL: true
            ),
            let queryItems = internalHost.queryItems
        else {
            return false
        }

        if
            host == InternalScreens.detail.keyValueString,
            let carBrand = queryItems.first(where: { $0.name == "carBrand" })?.value,
            let carModel = queryItems.first(where: { $0.name == "carModel" })?.value
        {
            currentTab = .list
            currentInternalScreen = .detailParametrized(
                carBrand: carBrand,
                carModel: carModel
            )
            return true
        }

        return false
    }
}

extension DeepLinkManager {
    enum Tab: String {
        case home = "home"
        case list = "list"
    }

    enum InternalScreens {
        case detail
        case detailParametrized(
            carBrand: String,
            carModel: String
        )
    }
}

extension DeepLinkManager.InternalScreens {
    var keyValueString: String {
        switch self {
        case .detail, .detailParametrized:
            return "detail"
        }
    }
}
