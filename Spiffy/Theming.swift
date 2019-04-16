//
//  Theming.swift
//  Spiffy
//
//  Created by Balazs Hajagos on 2019. 04. 15..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

/// Interface for the themes. Theming types applies styles based on a key to passed targets.
public protocol Theming {
    /// Type of the keys of the styles in this theme
    associatedtype Key: Hashable
    
    /// The map pairing the keys and styles together
    var styleMap: [Key: Styling] { get }
    
    /// Applies the styles identified by the key onto the target
    ///
    /// - Parameters:
    ///   - key: The key to get the styles for
    ///   - target: The target that should be styled
    func apply<T>(key: Key, to target: T)
}

// MARK: - Default implementation for the apply function
public extension Theming {
    func apply<T>(key: Key, to target: T) {
        styleMap[key]?.apply(to: target)
    }
}

// MARK: - Theme
/// Minimal theme class that helps creating themes on the fly. The generic helps with passing reused key sets.
public class Theme<K: Hashable>: Theming {
    public typealias Key = K
    public private(set) var styleMap: [K : Styling]
    
    public init(styleMap: [K: Styling]) {
        self.styleMap = styleMap
    }
}
