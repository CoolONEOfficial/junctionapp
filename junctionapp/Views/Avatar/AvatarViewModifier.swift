//
//  AvatarView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import SwiftUI
import SwiftUIX

struct AvatarViewModifier: ViewModifier {
    @StateObject var viewModel = AvatarViewModel()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject private var theme: Theme
    
    func body(content: Content) -> some View {
        Group {
            if let avatar = viewModel.avatar {
                content.blurIf(avatar.message != nil, Constants.blur).overlay(alignment: .topTrailing) {
                    VStack(alignment: .trailing) {
                        Text(avatar.state.emoji).fontSize(30).padding(10).background(Color.accent).clipCircle()
                        if let message = avatar.message {
                            Text(message)
                                .fontSize(13).foregroundColor(theme.text).multilineTextAlignment(.trailing).padding(.horizontal, 14).padding(.vertical, 10).background(PartRoundedRectangle(corners: [.topLeading, .bottomTrailing, .bottomLeading], cornerRadii: Constants.cornerRadius).fill(Color.systemBackground)).padding(.trailing, 4)
                        }
                    }.padding(.horizontal, 20)
                }.onTapGesture {
                    withAnimation {
                        viewModel.avatar?.message = nil
                    }
                }
            } else {
                content
            }
        }.onAppear { viewModel.onAppear() }
            .onDisappear(perform: viewModel.onDisappear)
    }
}

//struct AvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarView()
//    }
//}
