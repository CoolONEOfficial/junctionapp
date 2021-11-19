//
//  NotificationsViewModifier.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import Foundation
import SwiftUI

struct NotificationsViewModifier: ViewModifier {
    
    @StateObject var viewModel: NotificationsViewModel
    
    func body(content: Content) -> some View {
        content.onAppear(perform: viewModel.onAppear).onDisappear(perform: viewModel.onDisappear)
    }
}
