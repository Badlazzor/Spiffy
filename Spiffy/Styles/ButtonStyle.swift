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
            ///
            /// - title(color:for:)
            /// - background(color:for:)
            /// - background(image:for:)
            public enum Property {
                case titleColor(with: UIColor, for: UIControl.State)
                case backgroundColor(with: UIColor?, for: UIControl.State)
                case backgroundImage(with: UIImage?, for: UIControl.State)
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
                    print(StylingError.couldNotApply(to: "\(target)").localizedDescription)
                }
            }
            
            private func apply(to target: UIButton) {
                properties.forEach { property in
                    switch property {
                    case .titleColor(with: let color, for: let state):
                        target.setTitleColor(color, for: state)
                    case .backgroundColor(with: let color, for: let state):
                        target.setBackgroundImage(Style.image(with: color), for: state)
                    case .backgroundImage(with: let image, for: let state):
                        target.setBackgroundImage(image, for: state)
                    }
                }
            }
            
            private static func image(with color: UIColor?) -> UIImage? {
                guard let color = color else { return nil }
                let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
                UIGraphicsBeginImageContext(rect.size)
                let context = UIGraphicsGetCurrentContext()
                
                context?.setFillColor(color.cgColor)
                context?.fill(rect)
                
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return image
            }
        }
    }
}
