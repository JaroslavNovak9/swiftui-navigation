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

    private var selectedLink: Binding<CarDetailCoordinator.Flow?> {
        Binding {
            coordinator.selectedLink?.navigationLink
        } set: {
            coordinator.selectedLink = $0
        }
    }

    var body: some View {
        ZStack {
            content()

            navigationLinks
        }
    }

    private func technicalInfoDestination() -> some View {
        CarTechnicalInfoView()
    }

    private var navigationLinks: some View {
        NavigationLink(
            tag: .technicalInfo,
            selection: selectedLink,
            destination: technicalInfoDestination
        ) {
            EmptyView()
        }
    }
}

struct CarDetailCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailCoordinatorView(
            coordinator: .init(
                deepLinkManager: .init()
            ),
            content: { EmptyView() }
        )
    }
}