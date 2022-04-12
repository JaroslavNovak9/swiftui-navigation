//
//  IdentificationCoordinator.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import Combine
import SwiftUI

final class IdentificationCoordinator: ObservableObject {

    @Published var activeLink: IdentificationCoordinator.ScreenLink?
    private let deepLinkManager: DeepLinkManager
    private var savedDeepLink: DeepLink?

    let userSuccessfullyIdentified = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

// MARK: - Init

    init(deepLinkManager: DeepLinkManager) {
        self.deepLinkManager = deepLinkManager
        // Setup
        setupDeepLinking()
    }

// MARK: - Bindings

    private func setupDeepLinking() {
        deepLinkManager
            .outDeepLink
            .sink { [weak self] deepLink in
                guard let deepLink = deepLink else { return }

                print("ZDE catched first \(deepLink)")

                self?.savedDeepLink = deepLink
            }
            .store(in: &cancellables)

        userSuccessfullyIdentified
            .sink { [weak self] _ in
                print("ZDE repeat \(self?.savedDeepLink)")

                self?.deepLinkManager.repeatDeepLinkCall(
                    with: self?.savedDeepLink
                )
            }
            .store(in: &cancellables)
    }

// MARK: - Making coordinators

    private func makeCarListCoordinator(
        deepLink: DeepLink?
    ) -> CarsListCoordinator {
        .init(
            deepLinkManager: deepLinkManager
        )
    }

// MARK: - Making views

    func provideCoordinatorView<T: View>(for content: @escaping () -> T) -> some View {
        IdentificationCoordinatorView(
            coordinator: self,
            content: content
        )
    }

    func provideCarsListView() -> some View {
        let view: CarsListView = .init(
            viewModel: CarsListVM(
                coordinator: self.makeCarListCoordinator(deepLink: nil)
            )
        )

        return view
    }
}
