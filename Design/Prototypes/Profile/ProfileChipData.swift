//
//  ProfileChipData.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import Foundation

struct ChipItem: Identifiable {
    let id: UUID = UUID()
    let text: String
    let isMenu: Bool
    let subItems: [ChipItem]?
    
    init(text: String, isMenu: Bool = false, subItems: [ChipItem]? = nil) {
        self.text = text
        self.isMenu = isMenu
        self.subItems = subItems
    }
}

let chips: [ChipItem] = [
    ChipItem(text: "Featured"),
    ChipItem(
        text: "Timeline",
        isMenu: true,
        subItems: [
            ChipItem(text: "Posts"),
            ChipItem(text: "Posts and Replies"),
            ChipItem(text: "Media")
        ]
    ),
    ChipItem(text: "About"),
    ChipItem(
        text: "Saved",
        isMenu: true,
        subItems: [
            ChipItem(text: "Bookmarks"),
            ChipItem(text: "Favorites")
        ]
    )
]
