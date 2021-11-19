//
//  MainView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 19.11.2021.
//

import SwiftUI
import SwiftUIX
import SwiftUIPullToRefresh

struct MainView: View {
    @EnvironmentObject var theme: Theme
    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let data = viewModel.data {
                    ScrollView {
                        VStack {
                            ForEach(enumerating: data, id: \.id) { _, entry in
                                Text(entry.name ?? String(entry.id)).padding()
                            }
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.task()
        }
    }
}


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
