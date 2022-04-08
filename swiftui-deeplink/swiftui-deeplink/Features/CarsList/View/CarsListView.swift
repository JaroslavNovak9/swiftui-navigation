//
//  CarsListView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import SwiftUI

struct CarsListView: View {

    let viewModel: CarsListVM

    var body: some View {
        CarsListCoordinatorView(
            coordinator: viewModel.carsListCoordinator,
            content: content
        )
    }

    // Content of current screen
    private func content() -> some View {
        List(
            viewModel.list,
            id: \.id
        ) { car in
            detailLink(
                id: car.id,
                brand: car.brand.stringTitle,
                model: car.model
            )
        }
        .navigationTitle("Autopark")
    }

    private func detailLink(
        id: String,
        brand: String,
        model: String
    ) -> some View {
        Button {
            viewModel.openDetail(
                carBrand: brand,
                carModel: model
            )
        } label: {
            Text("\(brand) \(model)")
        }
    }
}

struct CarsListView_Previews: PreviewProvider {
    static var previews: some View {
        CarsListView(
            viewModel: .init(
                carsListCoordinator: .init(
                    deepLinkManager: .init()
                )
            )
        )
    }
}
