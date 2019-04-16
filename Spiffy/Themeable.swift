//
//  Themeable.swift
//  Spiffy
//
//  Created by Balazs Hajagos on 2019. 04. 15..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

/// Interface for things that may be themed
public protocol Themeable {
    
    /// Applies a theme on the target based on a key
    ///
    /// - Parameters:
    ///   - key: The key of the styles to be applied to the target
    ///   - theme: The theme from which the styles should be applied
    /// - Returns: The discardable self modified by the theme
    @discardableResult
    func themed<T: Theming>(as key: T.Key, from theme: T) -> Self
}

// MARK: - Default implementation of the Themeable protocol
public extension Themeable {
    @discardableResult
    func themed<T: Theming>(as key: T.Key, from theme: T) -> Self {
        theme.apply(key: key, to: self)
        return self
    }
}

// MARK: - UIView extension
// UIViews are themeable
extension UIView: Themeable {}
