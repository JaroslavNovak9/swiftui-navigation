//
//  CarDealershipView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 19.04.2022.
//

import SwiftUI

struct CarDealershipView: View {

    @StateObject var viewModel: CarDealershipVM

    var body: some View {
        CarDealershipCoordinatorView(
            route: $viewModel.selectedRoute
        ) {
            VStack {
                Text("Dealership")

                Button {
                    viewModel.openInfo()
                } label: {
                    Text("See dealership info")
                }
            }
        }
    }
}

extension CarDealershipView {
    struct DealershipInfo: Equatable, Hashable {
        let name: String
        let address: String
        let isOpened: Bool
    }
}

struct CarDealershipView_Previews: PreviewProvider {
    static var previews: some View {
        CarDealershipView(viewModel: .init())
    }
}
