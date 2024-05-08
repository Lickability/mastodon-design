//
//  Text+Collapsible.swift
//  Design
//
//  Created by Sam on 2024-04-09.
//

import SwiftUI

public enum TextCollapsiblePresentationStyle: Sendable {
    case inline
    case modal
}

struct Collapsible: ViewModifier {
    var maxLines: Int = 3
    var style: TextCollapsiblePresentationStyle = .inline
    @Binding var isCollapsed: Bool
    
    //  MARK: Single-line invisible text view to use as our fadeout gradient anchor
    @ViewBuilder
    func SingleLineGradient(_ content: Content) -> some View {
        content
            .lineLimit(1)
            .accessibilityHidden(true)
            .foregroundStyle(.clear)
            .background {
                //  MARK: Using 3 color stops to fade out earlier than the trailing point.
                //  I didn't want to hard-code some value before trailing. But by giving the system one clear and two opaques, the gradient fades to full opacity halfway through the gradient frame width.
                LinearGradient(colors: [.clear, Color(uiColor: .systemBackground), Color(uiColor: .systemBackground)], startPoint: .center, endPoint: .trailing)
            }
    }
    
    func body(content: Content) -> some View {
        switch style {
        case .inline:
            ZStack(alignment: .trailingLastTextBaseline, content: {
                content
                    .lineLimit(isCollapsed ? maxLines : nil)
                SingleLineGradient(content)
                Button(action: {
                    withAnimation {
                        isCollapsed.toggle()
                    }
                }, label: {
                    Text(isCollapsed ? "More" : "Less")
                })
            })
        case .modal:
            ZStack(alignment: .trailingLastTextBaseline, content: {
                content
                    .lineLimit(maxLines)
                SingleLineGradient(content)
                Button(action: {
                    withAnimation {
                        isCollapsed.toggle()
                    }
                }, label: {
                    Text(isCollapsed ? "More" : "Less")
                })
                .sheet(isPresented: Binding<Bool>(
                    get: { !isCollapsed },
                    set: { isCollapsed = !$0 }
                ), content: {
                    content
                })
            })
        }
    }
}

struct CollapsibleView: View {
    @State private var collapsed = true
    
    var body: some View {
        Text("Ex eiusmod incididunt eu adipisicing ut dolor dolore mollit labore est labore minim. Labore ex irure culpa consectetur. Cupidatat eu voluptate enim in. Velit exercitation adipisicing ex et ipsum fugiat. Lorem esse ea et et tempor velit laboris deserunt anim voluptate esse excepteur. Minim duis consequat ex. Cupidatat est pariatur eiusmod. Minim do sunt id esse sint consectetur dolor.\n\nMinim consectetur exercitation officia et magna occaecat do aliqua. Nostrud qui fugiat aliquip. Non mollit irure dolor occaecat sint ex id sit dolore elit labore nisi sunt. Commodo ipsum nisi aute ex qui cillum reprehenderit aliquip elit. Cillum veniam labore deserunt culpa incididunt ea. Labore mollit dolor aliquip ullamco ipsum cupidatat nostrud do ipsum aute id esse consequat. Dolor ea amet culpa do et pariatur dolore nulla nulla dolore. Nulla do eu ad commodo et.")
            .modifier(Collapsible(maxLines: 3, style: .modal, isCollapsed: $collapsed))
            .padding(.horizontal)
    }
}

struct CollapsibleText_Previews: PreviewProvider {
    static var previews: some View {
        CollapsibleView()
    }
}
