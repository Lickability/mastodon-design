//
//  ChipView.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI

struct ChipView: View {
    let chip: ChipItem
    @ObservedObject var viewModel: ChipsViewModel

    var body: some View {
        Menu(content: {
            menuContent
        }, label: {
            labelContent
        }, primaryAction: {
            withAnimation(.interactiveSpring(duration: 0.4)) {
                viewModel.selectChip(id: chip.id)
            }
        })
        .animation(.interactiveSpring(duration: 0.4), value: viewModel.displayText(for: chip))
    }

    @ViewBuilder
    private var menuContent: some View {
        if chip.isMenu, let subItems = chip.subItems {
            Picker("Pick an option", selection: bindingForPicker) {
                ForEach(subItems) { item in
                    Text(item.text).tag(Optional(item.id))
                }
            }
        }
    }

    @ViewBuilder
    private var labelContent: some View {
        HStack {
            Text(viewModel.displayText(for: chip))
            if chip.isMenu {
                Image(systemName: "chevron.up.chevron.down")
                    .imageScale(.small)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(viewModel.isSelected(chip: chip) ? Color(uiColor: .secondarySystemFill) : .clear)
        .clipShape(Capsule())
        .fixedSize(horizontal: true, vertical: false)
    }

    private var bindingForPicker: Binding<UUID?> {
        Binding<UUID?>(
            get: { viewModel.selectedSubItemIDs[chip.id] },
            set: { newValue in
                if let newValue = newValue {
                    viewModel.selectSubItem(parentID: chip.id, subItemID: newValue)
                }
            }
        )
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(chip: chips[1], viewModel: ChipsViewModel(chips: chips))
    }
}
