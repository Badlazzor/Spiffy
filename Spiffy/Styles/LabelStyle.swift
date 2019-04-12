//
//  LabelStyle.swift
//  Styling
//
//  Created by Hajagos Balázs on 2019. 02. 05..
//

import UIKit

/// Interaface to gather all UILabel targeted styles
public protocol LabelStyling: Styling {}

// MARK: - Label Styles
extension Styles {
    
    /// Label related styling
    public enum Label {
        
        /// Style targeted on UILabels
        public struct Style: LabelStyling {
            
            /// Possible properties of a Label.Style
            ///
            /// - alignment: text alignment
            /// - font: font of the text
            /// - numberOfLines: number of lines in the label
            /// - textColor: color of the text
            public enum Property {
                case alignment(NSTextAlignment)
                case color(UIColor)
                case font(UIFont)
                case lines(Int)
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
                case let target as UILabel:
                    apply(to: target)
                default:
                    print("Could not apply \(self) to \(target.self)")
                }
            }
            
            private func apply(to target: UILabel) {
                properties.forEach { property in
                    switch property {
                    case let .alignment(alignment):
                        target.textAlignment = alignment
                    case let .color(color):
                        target.textColor = color
                    case let .font(font):
                        target.font = font
                    case let .lines(lines):
                        target.numberOfLines = lines
                    }
                }
            }
        }
        
        // MARK: - Predefined styles
        public enum Predefined {
            /// A LabelStyle to set infinite number of lines on the UILabel
            public static let multilined = Style(.lines(0))
        }
    }
}
