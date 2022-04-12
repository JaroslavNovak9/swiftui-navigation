//
//  DeepLinkManager.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import Combine
import Foundation
import UIKit

final class DeepLinkManager: ObservableObject {

    @Published var currentTab: Tab = .home
    private var savedDeepLink: DeepLink?
    private var isUserIdentified: Bool

    private var deepLinkSubject = PassthroughSubject<DeepLink?, Never>()
    var outDeepLink: AnyPublisher<DeepLink?, Never> {
        deepLinkSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()

    init(isUserIdentified: Bool = false) {
        self.isUserIdentified = isUserIdentified
        // Bindings
        setupBindings()
    }

// MARK: - Public methods

    func repeatDeepLinkCall() {
        deepLinkSubject.send(savedDeepLink)
        savedDeepLink = nil
    }

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
            )
        else {
            return false
        }

        // carapp://carDetail?carBrand=Nissan&carModel=Patrol
        if
            host == DeepLink.carDetail.id,
            let queryItems = internalHost.queryItems,
            let carBrand = queryItems.first(where: { $0.name == "carBrand" })?.value,
            let carModel = queryItems.first(where: { $0.name == "carModel" })?.value
        {
            print("Making carDetail active")

            currentTab = .list
            deepLinkSubject.send(
                .carDetailParametrized(
                    carBrand: carBrand,
                    carModel: carModel
                )
            )
            return true
        }

        // carapp://carTechnicalInfo
        if
            host == DeepLink.carTechnicalInfo.id
        {
            print("Making carTechnicalInfo active")

            currentTab = .list
//            deepLinkSubject.send(
//                .carDetailParametrized(
//                    carBrand: "",
//                    carModel: "",
//                    nestedLink: .carTechnicalInfo
//                )
//            )
            deepLinkSubject
                .send(
                    .carTechnicalInfoParametrized(
                        nestedLink: .carAssistance
                    )
                )
            return true
        }

        // carapp://carAssistance
        if
            host == DeepLink.carAssistance.id
        {
            currentTab = .list
            deepLinkSubject.send(
                .carDetailParametrized(
                    carBrand: "",
                    carModel: "",
                    nestedLink: .carTechnicalInfoParametrized(
                        nestedLink: .carAssistance
                    )
                )
            )
//            deepLinkSubject
//                .send(
//                    .carDetailParametrized(
//                        carBrand: "",
//                        carModel: "",
//                        nestedLink: .carAssistance
//                    )
//                )
            return true
        }

        return false
    }

// MARK: - Setting up bindings

    private func setupBindings() {
        deepLinkSubject
            .sink { [weak self] deepLink in
                self?.savedDeepLink = deepLink
            }
            .store(in: &cancellables)
    }
}

extension DeepLinkManager {
    enum Tab: String {
        case home = "home"
        case list = "list"
    }
}
