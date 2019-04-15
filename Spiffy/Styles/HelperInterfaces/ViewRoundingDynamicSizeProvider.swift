//
//  ViewRoundingDynamicSizeProvider.swift
//  Spiffy
//
//  Created by Balazs Hajagos on 2019. 04. 15..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

/// Protocol to provide dynamic view sizes for styles
public protocol ViewRoundingDynamicSizeProvider {
    
    /// Size change handlers collection.
    var sizeChangeHandlers: [() -> Void] { get set }
    
    /// Register an action to take on size change
    ///
    /// - Parameters:
    ///   - for: The view whose size change is relevant for this style
    ///   - action: The action to take on size changes
    func registerDynamicSizeChangeAction(for view: UIView, action: @escaping (CGSize) -> Void)
}

extension ViewRoundingDynamicSizeProvider {
    /// Default implementation for registerDynamicSizeChangeAction
    mutating func registerDynamicSizeChangeAction(for view: UIView, action: @escaping (CGSize) -> Void) {
        sizeChangeHandlers.append({ [weak view] in
            guard let size = view?.bounds.size else { return }
            action(size)
        })
    }
}
