//
//  AuthorHeader.swift
//  Design
//
//  Created by Sam on 2024-03-27.
//

import SwiftUI

extension TimelinePostCell {
    struct AuthorHeader: View {
        var body: some View {
            HStack(spacing: 4) {
                Text("sam henri gold")
                    .bold()
                    .foregroundStyle(.primary)
                Text(verbatim: "@samhenrigold@hachyderm.io")
                Spacer()
                Text("5m")
            }
            .foregroundStyle(.secondary)
            .lineLimit(1)
            .font(.callout)
        }
    }
}

#Preview {
    TimelinePostCell.AuthorHeader()
}
