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
    
    /// Base Button stlye
    public struct Button: ButtonStyling {
        
        /// Possible properties of a Button.Style
        ///
        /// - title(color:for:)
        /// - background(color:for:)
        /// - background(image:for:)
        public enum Property {
            case autoHighlightImage(Bool)
            case backgroundColor(with: UIColor?, for: UIControl.State)
            case backgroundImage(with: UIImage?, for: UIControl.State)
            case font(UIFont)
            case titleColor(with: UIColor, for: UIControl.State)
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
                print(SpiffyError.couldNotApply(style: "\(self)", to: "\(target)").description)
            }
        }
        
        private func apply(to target: UIButton) {
            properties.forEach { property in
                switch property {
                case .autoHighlightImage(let adjust):
                    target.adjustsImageWhenHighlighted = adjust
                case .backgroundColor(with: let color, for: let state):
                    target.setBackgroundImage(Button.image(with: color), for: state)
                case .backgroundImage(with: let image, for: let state):
                    target.setBackgroundImage(image, for: state)
                case .font(let font):
                    target.titleLabel?.font = font
                case .titleColor(with: let color, for: let state):
                    target.setTitleColor(color, for: state)
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
