//
//  CarsListView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 17.03.2022.
//

import SwiftUI

struct CarsListView: View {

    @StateObject var viewModel: CarsListVM

    var body: some View {
        viewModel.coordinator.provideCoordinatorView(for: content)
    }

    // Content of current screen
    private func content() -> some View {
        VStack {
            HStack {
                Button {
                    viewModel.openAssistance()
                } label: {
                    Text("Vehicle assistance")
                }
                .buttonStyle(.automatic)
                Spacer()
            }
            .padding(.horizontal, 24)

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
                coordinator: .init(
                    deepLinkManager: .init()
                )
            )
        )
    }
}
