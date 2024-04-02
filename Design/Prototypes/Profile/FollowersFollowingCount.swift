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
    
    var body: some View {
        NavigationLink { } label: {
            Text(compactNumber(count)).bold() + Text(" " + text).foregroundStyle(.secondary)
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    FollowersFollowingCount(count: 12800, text: "followers")
}
