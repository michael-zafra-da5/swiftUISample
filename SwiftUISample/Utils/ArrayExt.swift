//
//  ArrayExt.swift
//  SwiftUISample
//
//  Created by Michael Angelo Zafra on 1/28/22.
//

import Foundation

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
