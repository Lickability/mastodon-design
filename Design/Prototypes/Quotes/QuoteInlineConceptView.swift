//
//  QuoteInlineConceptView.swift
//  Design
//
//  Created by Sam Gold on 2024-10-29.
//

import SwiftUI

struct QuoteInlineConceptView: View {
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.quaternary)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("sam henri gold")
                    .bold()
                
                Text(verbatim: "@samhenrigold@example.com")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                // MARK: Quote attachment
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.quaternary)
                            .frame(width: 18, height: 18)
                        
                        Text("someone")
                            .bold()
                        
                        Text(verbatim: "@someone@example.com")
                            .foregroundStyle(.secondary)
                    }
                    
                    Text("just finished renovating my kitchen and i'm soooo happy with how it turned out!\n\nhighly recommend updating your cabinets if your kitchen is feeling dated, it gets you 80% of the way to feeling like a new kitchen")
                        .lineLimit(6)
                        .foregroundStyle(.primary.opacity(0.8))
                }
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.separator)
                }
                
                Spacer()
                    .frame(height: 12)
                
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
                .foregroundStyle(.accent)
                .font(.subheadline)
                
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
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    QuoteInlineConceptView()
}
