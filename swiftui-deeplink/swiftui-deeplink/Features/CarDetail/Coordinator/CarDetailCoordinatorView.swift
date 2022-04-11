//
//  CarDetailCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

struct CarDetailCoordinatorView<Content: View>: View {

    @ObservedObject var coordinator: CarDetailCoordinator
    let content: () -> Content

    private var activeLink: Binding<CarDetailCoordinator.ScreenLink?> {
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
            tag: .carTechnicalInfo,
            selection: activeLink,
            destination: coordinator.provideTechnicalInfoView
        ) {
            EmptyView()
        }
    }
}

struct CarDetailCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailCoordinatorView(
            coordinator: .init(
                deepLink: nil
            ),
            content: { EmptyView() }
        )
    }
}
