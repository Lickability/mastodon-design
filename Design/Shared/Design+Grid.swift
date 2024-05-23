//
//  Design+Grid.swift
//  Design
//
//  Created by Sam on 2024-05-23.
//

import Foundation

struct Design {
    enum Grid {
        /// 44 points (minimum recommended tap target size)
        static let minTapTarget: CGFloat = 44

        /// 2 points
        static let s_25: CGFloat = 2
        /// 4 points
        static let s_5: CGFloat  = 4
        /// 8 points
        static let s1: CGFloat   = 8
        /// 12 points
        static let s1_5: CGFloat = 12
        /// 16 points
        static let s2: CGFloat   = 16
        /// 24 points
        static let s3: CGFloat   = 24
        /// 32 points
        static let s4: CGFloat   = 32
        /// 40 points
        static let s5: CGFloat   = 40
        /// 48 points
        static let s6: CGFloat   = 48
        /// 56 points
        static let s7: CGFloat   = 56
        /// 64 points
        static let s8: CGFloat   = 64
        /// 72 points
        static let s9: CGFloat   = 72
        /// 80 points
        static let s10: CGFloat  = 80
        /// 88 points
        static let s11: CGFloat  = 88
        /// 96 points
        static let s12: CGFloat  = 96
        /// 104 points
        static let s13: CGFloat  = 104
        /// 112 points
        static let s14: CGFloat  = 112
        /// 120 points
        static let s15: CGFloat  = 120
        /// 128 points
        static let s16: CGFloat  = 128
        /// 144 points
        static let s18: CGFloat  = minTapTarget
        /// 192 points
        static let s24: CGFloat  = 192
    }

}
