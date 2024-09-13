//
//  Tab+Modifiers.swift
//  Example
//
//  Created by Nicholas Bellucci on 5/13/20.
//  Copyright © 2020 Nicholas Bellucci. All rights reserved.
//

import SwiftUI

public extension StatefulTabViewTab {
    func prefersLargeTitle(_ bool: Bool) -> StatefulTabViewTab {
        var copy = self
        copy.prefersLargeTitle = bool
        return copy
    }
}
