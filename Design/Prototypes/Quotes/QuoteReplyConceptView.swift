//
//  QuoteReplyConceptView.swift
//  Design
//
//  Created by Sam Gold on 2024-10-29.
//

import SwiftUI

struct QuoteReplyConceptView: View {
    var body: some View {
        Grid(alignment: .top) {
            GridRow {
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.quaternary)
                        .frame(width: 34, height: 34)
                    
                    Capsule()
                        .fill(.separator)
                        .frame(width: 2)
                        .frame(maxHeight: 96)
                }
                
                VStack(alignment: .leading) {
                    Text("someone")
                        .font(.subheadline)
                        .bold()
                    
                    Text(verbatim: "@helloworld@example.com")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    Text("just finished renovating my kitchen and i'm soooo happy with how it turned out\nhighly recommend updating your cabinets if your kitchen is feeling dated, it gets you 80% of the way to feeling like a new kitchen")
                        .font(.subheadline)
                        .lineLimit(4)
                        .foregroundStyle(.primary.opacity(0.8))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            GridRow {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.quaternary)
                    .frame(width: 44, height: 44)
                
                VStack(alignment: .leading) {                    
                    Text("sam henri gold")
                        .bold()
                    
                    Text(verbatim: "@samhenrigold@example.com")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    Text("if anyone else is in this situation, you can try just painting the cabinets. the underlying design likely isn’t half bad.\n\ni wrote more about it in this thread:")
                    
                    HStack {
                        Text("Post by sam henri gold")
                        Image(systemName: "chevron.forward")
                            .imageScale(.small)
                    }
                    .bold()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(.accent.quinary, in: RoundedRectangle(cornerRadius: 8))
                    .font(.callout)
                    .foregroundStyle(.accent)
                    
                    Spacer()
                        .frame(height: 16)
                    
                    HStack {
                        Button("Reply", systemImage: "arrowshape.turn.up.left") {}
                        
                        Spacer()
                        
                        Button("Boost", systemImage: "arrow.2.squarepath") {}
                        
                        Spacer()
                        
                        Button("Favorite", systemImage: "star") {}
                        
                        Spacer()
                        
                        Spacer()
                        
                        Button("Bookmark", systemImage: "bookmark") {}
                        
                        Spacer()
                        
                        Button("Share", systemImage: "square.and.arrow.up") {}
                    }
                    .tint(.secondary)
                    .labelStyle(.iconOnly)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    QuoteReplyConceptView()
}
