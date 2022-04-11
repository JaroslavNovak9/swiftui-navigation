//
//  CarTechnicalInfoView.swift
//  swiftui-deeplink
//
//  Created by Jaroslav Novák on 18.03.2022.
//

import SwiftUI

struct CarTechnicalInfoView: View {

    @StateObject var viewModel: CarTechnicalInfoVM

    var body: some View {
        viewModel.coordinator.provideCoordinatorView(for: content)
    }

    func content() -> some View {
        Text("Car technical info")
    }
}

struct CarTechnicalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CarTechnicalInfoView(
            viewModel: .init(
                coordinator: .init(
                    deepLink: nil
                )
            )
        )
    }
}
