//
//  Styleable.swift
//  InfinityRoster
//
//  Created by Balazs Hajagos on 2019. 04. 11..
//  Copyright © 2019. Badlazzor. All rights reserved.
//

import UIKit

/// Interface for things that may be styled.
public protocol Styleable {
    
    /// Apply a style to this entity
    ///
    /// - Parameter style: The style to be applied
    /// - Returns: A discardable version of this entity modified by the style
    @discardableResult
    func styled(by style: Styling) -> Self
    
    /// Apply an array of styles to this entity
    ///
    /// - Parameter styles: The array of styles to be applied
    /// - Returns: A discardable version of this entity modified by the given styles
    @discardableResult
    func styled(by styles: [Styling]) -> Self
}

/// Default extension of Styleable methods
public extension Styleable {
    @discardableResult
    public func styled(by style: Styling) -> Self {
        style.apply(to: self)
        return self
    }
    
    @discardableResult
    public func styled(by styles: [Styling]) -> Self {
        styles.forEach { $0.apply(to: self) }
        return self
    }
}

extension UIView: Styleable {}
