//
//  CarDealershipCoordinatorView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 19.04.2022.
//

import SwiftUINavigation
import SwiftUI

struct CarDealershipCoordinatorView<Content: View>: View {

    @Binding var route: CarDealershipCoordinatorRoute?
    let content: () -> Content

    private var activeRoute: Binding<CarDealershipCoordinatorRoute?> {
        Binding {
            route?.unparametrized
        } set: {
            route = $0
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
                tag: .dealershipInfo,
                selection: activeRoute,
                destination: { Text("Navigated to info") },
                label: { EmptyView() }
            )
        }
    }
}

struct CarDealershipCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CarDealershipCoordinatorView(
            route: .constant(nil),
            content: { EmptyView() }
        )
    }
}
