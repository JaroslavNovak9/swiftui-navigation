//
//  IdentificationVM.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import Combine
import SwiftUI

final class IdentificationVM: ObservableObject {

    @Binding var identified: Bool
    let coordinator: IdentificationCoordinator

    let identifyTapped = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    init(
        identified: Binding<Bool>,
        coordinator: IdentificationCoordinator
    ) {
        self._identified = identified
        self.coordinator = coordinator
        // Bindings
        setupBindings()
    }

    private func setupBindings() {
        identifyTapped
            .sink { [weak self] _ in
                self?.coordinator.userSuccessfullyIdentified.send()
                self?.identified = true
            }
            .store(in: &cancellables)
    }
}
