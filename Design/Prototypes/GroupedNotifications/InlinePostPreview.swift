//
//  InlinePostPreview.swift
//  Design
//
//  Created by Sam on 2024-05-08.
//

import SwiftUI

struct InlinePostPreview: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 16, height: 16)
                Text(post.account.displayName)
                    .bold()
                Text("@\(post.account.username)@\(post.account.server)")
                    .foregroundStyle(.secondary)
                Spacer(minLength: 0)
            }
            .lineLimit(1)
            .font(.subheadline)
            Text(post.content)
//                .font(.callout)
                .lineLimit(3)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .fill(.clear)
                .stroke(.separator)
        }
    }
}

#Preview {
    InlinePostPreview(post: SampleData.samplePost)
}
