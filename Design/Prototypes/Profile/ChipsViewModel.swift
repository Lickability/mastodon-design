//
//  ChipsViewModel.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI

class ChipsViewModel: ObservableObject {
    @Published var chips: [ChipItem]
    @Published var selectedChipID: UUID?
    var selectedSubItemIDs: [UUID: UUID] = [:] // Maps parent ID to selected subitem ID
    var lastSelectedSubItemText: [UUID: String] = [:] // Maps parent ID to last selected subitem text
    
    init(chips: [ChipItem]) {
        // Initialize the chips array, potentially modifying chips with subitems to set their default label
        var modifiedChips = [ChipItem]()
        for chip in chips {
            if let firstSubItem = chip.subItems?.first {
                // Optionally store the first subitem's text as the last selected text for this chip
                lastSelectedSubItemText[chip.id] = firstSubItem.text
            }
            modifiedChips.append(chip)
        }
        self.chips = modifiedChips
    }
    
    func selectChip(id: UUID?) {
        if let id = id {
            // If selecting a different chip, clear any selected subitem for the previously selected chip
            if let currentSelectedChipID = selectedChipID, currentSelectedChipID != id {
                selectedSubItemIDs[currentSelectedChipID] = nil
            }
            selectedChipID = id
        } else {
            // If id is nil, it means deselecting any chip, so clear selectedChipID
            selectedChipID = nil
        }
    }
    
    func selectSubItem(parentID: UUID, subItemID: UUID) {
        // This is called when a subitem is directly selected
        selectedChipID = parentID // Mark the parent as selected
        selectedSubItemIDs[parentID] = subItemID // Remember the selected subitem
        // Update last selected subitem text
        if let subItem = chips.flatMap({ $0.subItems ?? [] }).first(where: { $0.id == subItemID }) {
            lastSelectedSubItemText[parentID] = subItem.text
        }
    }
    
    func isSelected(chip: ChipItem) -> Bool {
        // A chip is selected if it's the current selectedChipID or a subitem of it is selected
        if let selectedChipID = selectedChipID {
            return chip.id == selectedChipID || selectedSubItemIDs[chip.id] != nil
        }
        return false
    }
    
    func displayText(for chip: ChipItem) -> String {
        // Display the last selected subitem text if available and applicable
        if let lastText = lastSelectedSubItemText[chip.id], chip.isMenu {
            return lastText
        }
        return chip.text
    }
}
