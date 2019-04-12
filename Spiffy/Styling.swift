//
//  Styling.swift
//  Spiffy
//
//  Created by Hajagos Balázs on 2019. 02. 05..
//

import UIKit

/// Interface for things that can style other things.
public protocol Styling {
    
    /// Apply this style to the target
    ///
    /// - Parameter target: A styleable entity
    func apply<T>(to target: T)
}

