//
//  SectionsView.swift
//  junctionapp
//
//  Created by Nickolay Truhin on 20.11.2021.
//

import DynamicColor
import Foundation
import SwiftUI

struct SectionsView: View {
    
    @EnvironmentObject var theme: Theme
    
    let sections: [String]
    @Binding var selectedIndexes: Set<Int>
    
    var isFluent = false
    var allEnabled = false

    var items: [String] {
        (allEnabled ? ["Все"] : []) + sections
    }

    @ViewBuilder
    func item(index: Int, item: String) -> some View {
        let isSelected = selectedIndexes.contains(index)
        let bg: Color = isFluent ? .systemBackground : isSelected ? theme.accent : .clear
        let padding: CGFloat = isFluent ? 20 : 30
        Caption(item, isSelected: isSelected)
            .padding(.horizontal, isSelected || isFluent ? 15 : 0)
            .padding(.vertical, 5)
            .background(RoundedRectangle(cornerRadius: 8).fill(bg))
            .padding(.leading, index == 0 ? padding : 0)
            .padding(.trailing, index == items.count - 1 ? padding : 0)
            .onTapGesture {
                withAnimation {
                    if isSelected {
                        selectedIndexes.remove(index)
                    } else {
                        selectedIndexes.insert(index)
                    }
                }
            }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(zip(items.indices, items)), id: \.0, content: item)
            }
        }.height(40)
    }
}
