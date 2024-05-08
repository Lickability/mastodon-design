//
//  TimelinePostCell.swift
//  Design
//
//  Created by Sam on 2024-03-27.
//

import SwiftUI

struct TimelinePostCell: View {
    var body: some View {
        Grid(alignment: .leading, verticalSpacing: 6) {
            BoostHeader()
            GridRow(alignment: .top) {
                Image("avatar")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.separator, lineWidth: 1)
                            .blendMode(.plusLighter)
                    }
                VStack(alignment: .leading) {
                    AuthorHeader()
                    Text("Exercitation esse ut culpa laboris voluptate ut cupidatat qui sunt tempor. Exercitation dolore anim quis dolore ut aliquip aute deserunt reprehenderit.")
                        .font(.callout)
//                    MediaGrid()
                    ActionButtons()
                        .padding(.vertical, 4)
                }
            }
        }
        .padding()
    }

}

#Preview {
    TimelinePostCell()
}
