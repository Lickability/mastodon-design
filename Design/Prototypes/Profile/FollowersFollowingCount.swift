//
//  FollowersFollowingCount.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import SwiftUI

struct FollowersFollowingCount: View {
    let count: Int
    let text: String
    
    var formattedNumber: String {
        let numberFormatter = NumberAbbreviationFormatter()
        return numberFormatter.string(for: count) ?? "0"
    }
    
    var body: some View {
        NavigationLink { } label: {
            Text(formattedNumber).bold() + Text(" " + text).foregroundStyle(.secondary)
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    FollowersFollowingCount(count: 12800, text: "followers")
}
