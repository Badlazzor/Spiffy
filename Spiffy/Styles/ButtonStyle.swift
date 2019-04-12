//
//  ButtonStyle.swift
//  Spiffy
//
//  Created by Hajagos Balázs on 2019. 02. 05..
//

import UIKit

/// Interaface to gather all UIButton targeted styles
public protocol ButtonStyling: Styling {}

// MARK: - Button Styles
extension Styles {
    
    /// Button related styling
    public enum Button {
        
        /// Style targeted on UIButton
        public struct Style: ButtonStyling {
            
            /// Possible properties of a Button.Style
            public enum Property {
            }
            
            private let properties: [Property]
            
            public init(_ propertyList: Property...) {
                self.properties = propertyList
            }
            
            public init(_ properties: [Property]) {
                self.properties = properties
            }
            
            public func apply<T>(to target: T) {
                switch target {
                case let target as UIButton:
                    apply(to: target)
                default:
                    print("Could not apply \(self) to \(target)")
                }
            }
            
            private func apply(to target: UIButton) {
                properties.forEach { property in
                    switch property {
                    }
                }
            }
        }
    }
}
