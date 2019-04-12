//
//  ViewStyle.swift
//  Spiffy
//
//  Created by Hajagos Balázs on 2019. 02. 05..
//

import UIKit

/// Interaface to gather all UIView targeted styles
public protocol ViewStyling: Styling {}

// MARK: - View Styles
extension Styles {
    
    /// Label related styling
    public enum View {
        
        /// Style targeted on UILabels
        public struct Style: ViewStyling {
            
            /// Possible properties of a View.Style
            ///
            /// - alpha
            /// - autolayouted - **true** or **false**
            /// - backgroundColor
            /// - contentMode
            /// - priority - **type**, **axis**, **value** triplets
            public enum Property {
                
                /// Possible priorities
                ///
                /// - contentHugging
                /// - compressionResistance
                public enum PriorityType {
                    case contentHugging
                    case compressionResistance
                }
                
                case alpha(CGFloat)
                case autolayouted(Bool)
                case backgroundColor(UIColor)
                case contentMode(UIView.ContentMode)
                case priority(PriorityType, NSLayoutConstraint.Axis, Float)
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
                case let target as UIView:
                    apply(to: target)
                default:
                    print("Could not apply \(self) to \(target)")
                }
            }
            
            private func apply(to target: UIView) {
                properties.forEach { property in
                    switch property {
                    case let .alpha(alpha):
                        target.alpha = alpha
                    case let .autolayouted(enabled):
                        target.translatesAutoresizingMaskIntoConstraints = !enabled
                    case let .backgroundColor(color):
                        target.backgroundColor = color
                    case let .contentMode(contentMode):
                        target.contentMode = contentMode
                    case let .priority(.contentHugging, axis, value):
                        target.setContentHuggingPriority(UILayoutPriority(rawValue: value), for: axis)
                    case let .priority(.compressionResistance, axis, value):
                        target.setContentCompressionResistancePriority(UILayoutPriority(rawValue: value), for: axis)
                    }
                }
            }
        }
        
        
        // MARK: - Predefined styles
        public enum Predefined {
            /// Autolayouted ViewStyle
            public static let autolayouted = Style(.autolayouted(true))
        }
    }
}
