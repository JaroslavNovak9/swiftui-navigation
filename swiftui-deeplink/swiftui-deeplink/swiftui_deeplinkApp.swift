//
//  swiftui_deeplinkApp.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import SwiftUI

@main
struct swiftui_deeplinkApp: App {

    @StateObject private var deepLinkManager: DeepLinkManager = .init()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(deepLinkManager)
                .onOpenURL { url in
                    // open link in safari: carapp://detail?carBrand=Nissan&carModel=Patrol

                    // DEBUG
                    if deepLinkManager.evaluateDeepLink(url: url) {
                        print("From deep link")
                    } else {
                        print("Fall back")
                    }
                }
        }
    }
}
