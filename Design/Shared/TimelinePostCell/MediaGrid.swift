//
//  MediaGrid.swift
//  Design
//
//  Created by Sam on 2024-03-28.
//

import SwiftUI

let images = [
    Image("ultrawide").resizable(),
    Image("screenshot").resizable(),
    Image("portrait").resizable(),
    Image("landscape").resizable(),
    Image("square").resizable()
]

extension TimelinePostCell {
    struct MediaGrid: View {
        var body: some View {
            VStack {
                Grid {
                    GridRow {
                        Rectangle()
                            .background {
                                images[0]
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                        Rectangle()
                            .background {
                                images[1]
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                    }
                    .aspectRatio(3/4, contentMode: .fit)
                    GridRow {
                        Rectangle()
                            .background {
                                images[4]
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                        Rectangle()
                            .background {
                                images[3]
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                    }
                    .aspectRatio(4/3, contentMode: .fit)
                }
                .foregroundStyle(.clear)
            }
        }
    }
    
}


#Preview {
    TimelinePostCell.MediaGrid()
}
