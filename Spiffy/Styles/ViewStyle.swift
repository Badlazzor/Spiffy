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
    public struct View: ViewStyling {
        
        /// Possible properties of a View.Style
        ///
        /// - alpha
        /// - autolayouted - **true** or **false**
        /// - backgroundColor
        /// - contentMode
        /// - priority - **type**, **axis**, **value** triplets
        /// - shadow - **opacity**, **radius**, **offset**, **color**
        public enum Property {
            
            /// Possible priorities
            ///
            /// - contentHugging
            /// - compressionResistance
            public enum PriorityType {
                case contentHugging
                case compressionResistance
            }
            
            /// Dynamic rounding value options
            ///
            /// - ratio: Ratio of the roundness relative to the dynamic valze
            /// - full: Always uses half of the dynamic size to achieve _'full roundness'_
            public enum DynamicRoundingType {
                case ratio(CGFloat)
                case full
            }
            
            /// The axis of the rounding
            ///
            /// - horizontal: The leading and trailing edges will be the sources of the dynamic value on which the rounding is based
            /// - vertical: The top and bottom edges will be the sources of the dynamic value on which the rounding is based
            public enum DynamicRoundingAxis {
                case horizontal
                case vertical
            }
            
            /// Possible view roundings
            ///
            /// - none: pointy corners
            /// - explicit: rounded corners with explicit radius
            /// - dynamic: registers an observer on the size changes to dynamically round the view
            public enum Rounding {
                case none
                case explicit(CGFloat)
                case dynamic(type: DynamicRoundingType, axis: DynamicRoundingAxis, with: ViewRoundingDynamicSizeProvider)
            }
            
            case alpha(CGFloat)
            case autolayouted(Bool)
            case backgroundColor(UIColor)
            case contentMode(UIView.ContentMode)
            case priority(PriorityType, NSLayoutConstraint.Axis, Float)
            case rounding(Rounding)
            case shadow(opacity: Float, radius: CGFloat, offset: CGSize, color: UIColor?)
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
                print(SpiffyError.couldNotApply(style: "\(self)", to: "\(target)").description)
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
                case let .rounding(rounding):
                    apply(rounding, to: target)
                case let .shadow(opacity, radius, offset, color):
                    target.layer.masksToBounds = false
                    target.layer.shadowOpacity = opacity
                    target.layer.shadowRadius = radius
                    target.layer.shadowOffset = offset
                    target.layer.shadowColor = color?.cgColor
                }
            }
        }
        
        private func apply(_ rounding: Property.Rounding, to target: UIView) {
            switch rounding {
            case .none:
                target.layer.masksToBounds = true
                target.layer.cornerRadius = 0.0
            case .explicit(let rounding):
                target.layer.masksToBounds = true
                target.layer.cornerRadius = rounding
            case .dynamic(let type, let axis, let sizeProvider):
                target.layer.masksToBounds = true
                var rate: CGFloat = 0.0
                switch type {
                case .ratio(let ratio):
                    rate = min(max(ratio, 0), 0.5)
                case .full:
                    rate = 0.5
                }
                
                sizeProvider.registerDynamicSizeChangeAction(for: target, action: { [weak target] size in
                    switch axis {
                    case .horizontal:
                        target?.layer.cornerRadius = size.height * rate
                    case .vertical:
                        target?.layer.cornerRadius = size.width * rate
                    }
                })
            }
        }
        
        // MARK: - Predefined styles
        public enum Predefined {
            /// Autolayouted ViewStyle
            public static let autolayouted = View(.autolayouted(true))
        }
    }
}
