//
//  BoostHeader.swift
//  Design
//
//  Created by Sam on 2024-03-28.
//

import SwiftUI

extension TimelinePostCell {
    struct BoostHeader: View {
        var body: some View {
            GridRow {
                Image(systemName: "repeat")
                    .gridColumnAlignment(.trailing)
                HStack(spacing: 0) {
                    Text("firstname last")
                        .truncationMode(.tail)
                        .fontWeight(.semibold)
                    Text(" boosted")
                }
            }
            .foregroundStyle(.secondary)
            .lineLimit(1)
            .font(.subheadline)
        }
    }
}

#Preview {
    Grid {
        TimelinePostCell.BoostHeader()
    }
}
