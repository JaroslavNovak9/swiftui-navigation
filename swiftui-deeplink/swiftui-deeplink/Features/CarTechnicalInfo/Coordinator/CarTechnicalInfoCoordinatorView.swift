//
//  CarTechnicalInfoCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 08.04.2022.
//

import SwiftUI

struct CarTechnicalInfoCoordinatorView<Content: View>: View {

    @StateObject var coordinator: CarTechnicalInfoCoordinator
    let content: () -> Content

    private var activeLink: Binding<CarTechnicalInfoCoordinator.ScreenLink?> {
        Binding {
            coordinator.activeLink?.unparametrized
        } set: {
            coordinator.activeLink = $0
        }
    }

    var body: some View {
        ZStack {
            content()

            navigationLinks
        }
    }

    private var navigationLinks: some View {
        NavigationLink(
            tag: .carAssistance,
            selection: activeLink,
            destination: coordinator.provideCarAssistanceView
        ) { EmptyView() }
    }
}

struct CarTechnicalInfoCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarTechnicalInfoCoordinatorView(
            coordinator: .init(
                deepLink: nil
            ),
            content: { EmptyView() }
        )
    }
}
