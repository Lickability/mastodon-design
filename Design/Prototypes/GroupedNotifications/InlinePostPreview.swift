//
//  InlinePostPreview.swift
//  Design
//
//  Created by Sam on 2024-05-08.
//

import SwiftUI

struct InlinePostPreview: View {
    let post: Post
    var needsUserAttribution = true
    var isPinned = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 4) {
                if needsUserAttribution {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 16, height: 16)
                    Text(post.account.displayName)
                        .bold()
                    Text("@\(post.account.username)@\(post.account.server)")
                        .foregroundStyle(.secondary)
                    Spacer(minLength: 0)
                } else if isPinned {
//                    This *should* be a Label but it acts funky when this is in a List (i.e. in UserList)
                    Group {
                        Image(systemName: "pin.fill")
                        Text("Pinned")
                    }
                    .bold()
                    .foregroundStyle(.secondary)
                    .imageScale(.small)
                }
            }
            .lineLimit(1)
            .font(.subheadline)
            Text(post.content)
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
    VStack {
        InlinePostPreview(post: SampleData.samplePost)
        InlinePostPreview(post: SampleData.samplePost, needsUserAttribution: false, isPinned: true)
    }
    .padding()
}
