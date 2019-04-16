//
//  SpiffyError.swift
//  Spiffy
//
//  Created by Balazs Hajagos on 2019. 04. 15..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

/// An error class to streamline mishaps inside the lib
///
/// - couldNotApply: The given style could not be applied to the specified target.
public enum SpiffyError: Error {
    case couldNotApply(style: String, to: String)
    
    var description: String {
        switch self {
        case let .couldNotApply(style, target):
            return "SpiffyError - Could not apply \(style) to \(target)"
        }
    }
}
