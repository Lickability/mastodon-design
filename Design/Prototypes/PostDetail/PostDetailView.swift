//
//  PostDetailView.swift
//  Design
//
//  Created by Sam on 2024-04-16.
//

import SwiftUI

struct PostDetailView: View {
    var lastEdit: Date {
        let now = Date()
        var calendar = Calendar.current

        calendar.timeZone = TimeZone.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        components.hour = 9
        components.minute = 41

        return calendar.date(from: components) ?? Date()
    }
    
    var publishDate: Date {
        let now = Date()
        var calendar = Calendar.current

        calendar.timeZone = TimeZone.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: now) ?? now
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: yesterday)
        components.hour = 10
        components.minute = 9

        return calendar.date(from: components) ?? Date()
    }
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        formatter.formattingContext = .middleOfSentence
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TimelinePostCell()
                List {
                    Text(publishDate.formatted(date: .abbreviated, time: .shortened))
                    Group {
                        Text("Last edited ").foregroundStyle(.secondary) +
                        Text(formatter.string(from: lastEdit))
                    }
                }
                .scrollDisabled(true)
                .font(.footnote)
                .listStyle(.plain)
            }
            .background(.background)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    PostDetailView()
}
