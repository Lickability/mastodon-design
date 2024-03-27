//
//  PickerChipItem.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI

struct PickerChipView: View {
    let isMenu: Bool
    let text: String
    @Binding var selected: Bool
    
    var body: some View {
        HStack {
            Text(text)
            if isMenu {
                Image(systemName: "chevron.up.chevron.down")
                    .imageScale(.small)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(selected ? Color(uiColor: .secondarySystemFill) : .clear)
        .clipShape(Capsule())
    }
}

#Preview {
    PickerChipView(isMenu: true, text: "Timeline", selected: .constant(true))
}
