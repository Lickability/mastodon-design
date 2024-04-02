//
//  NumberAbbreviationFormatter.swift
//  MastodonProfile
//
//  Created by Sam on 2024-03-11.
//

import Foundation

func compactNumber(_ int: Int) -> String {
    return int.formatted(.number.notation(.compactName))
}
