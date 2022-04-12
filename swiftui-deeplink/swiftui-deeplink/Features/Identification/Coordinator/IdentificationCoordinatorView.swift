//
//  IdentificationCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 11.04.2022.
//

import SwiftUI

struct IdentificationCoordinatorView<Content: View>: View {

    @ObservedObject var coordinator: IdentificationCoordinator
    let content: () -> Content

    private var activeLink: Binding<IdentificationCoordinator.ScreenLink?> {
        Binding {
            coordinator.activeLink?.unparametrized
        } set: {
            coordinator.activeLink = $0
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                content()

                navigationLinks
            }
        }
    }

    private var navigationLinks: some View {
        Group {
            NavigationLink(
                tag: .carsList,
                selection: activeLink,
                destination: coordinator.provideCarsListView
            ) { EmptyView() }
        }
    }
}

struct IdentificationCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        IdentificationCoordinatorView(
            coordinator: .init(
                deepLinkManager: .init()
            ),
            content: { EmptyView() }
        )
    }
}
