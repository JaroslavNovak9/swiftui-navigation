//
//  HomeView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var deepLinkManager: DeepLinkManager

    var body: some View {
        TabView(
            selection: $deepLinkManager.currentTab
        ) {
            Text("Home")
                .environmentObject(deepLinkManager)
                .tag(DeepLinkManager.Tab.home)
                .tabItem {
                    Image(systemName: "house.fill")
                }

            CarsListView(
                viewModel: .init(
                    carsListCoordinator: .init(deepLinkManager: deepLinkManager)
                )
            )
            .tag(DeepLinkManager.Tab.list)
            .tabItem {
                Image(systemName: "car")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
