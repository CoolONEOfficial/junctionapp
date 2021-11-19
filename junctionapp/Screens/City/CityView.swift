//
//  CityView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import SwiftUIX
import SwiftUIPullToRefresh
import MapKit
import PureSwiftUI
import BottomSheet
import DynamicColor

struct CityView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: CityViewModel

    @State var region: MKCoordinateRegion = .init()

    var body: some View {
        NavigationView {
            MapView(region: $region, points: $viewModel.houses.withDefaultValue([])) { house in
                
            }
            .ignoresSafeArea(.container, edges: [ .horizontal, .top ])
            .modifier(BottomSheetView(viewModel: viewModel))
        }.onChange(of: viewModel.houses) { _ in
            updateRegion()
        }
    }

    private func updateRegion() {
        guard let housesCenter = viewModel.housesCenter else { return }
        withAnimation {
            region.center = housesCenter
        }
    }
        
}

private struct BottomSheetView: ViewModifier {
    enum BottomSheetPosition: CGFloat, CaseIterable {
        //The state where the height of the BottomSheet is 97.5%
        case top = 0.975
        //The state where the height of the BottomSheet is 40%
        case middle = 0.5
        //The state where the height of the BottomSheet is 12.5% and the `mainContent` is hidden
        case bottom = 0.225
//        case hidden = 0
    }

    @State var bottomSheetPosition: BottomSheetPosition = .middle
    @StateObject var viewModel: CityViewModel
    @EnvironmentObject var theme: Theme
    
    func body(content: Content) -> some View {
        content.bottomSheet(
            bottomSheetPosition: $bottomSheetPosition.animation(),
            options: [.allowContentDrag, .appleScrollBehavior, .background(.init(Color.systemBackground))]
        ) { titleContent } mainContent: { mainContent }
    }

    var titleContent: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Title("Поиск...")
            SearchBar(text: $viewModel.query, onEditingChanged: isEditingDidChange, onCommit: onCommit).textFieldBackgroundColor(theme.accent).placeholder("Найти в предложениях")
                .padding(.horizontal, -8)
        }
    }
    
    var mainContent: some View {
        VStack {
            Text("fdf")
        }.maxHeight(.infinity)
    }

    func isEditingDidChange(isEditing: Bool) {
        if isEditing {
            withAnimation {
                bottomSheetPosition = .top
            }
        }
    }

    func onCommit() {
        Task {
            await viewModel.update()
        }
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}
