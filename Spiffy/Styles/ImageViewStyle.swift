//
//  ImageViewStyle.swift
//  Spiffy
//
//  Created by Hajagos Balázs on 2019. 02. 12..
//

import UIKit

/// Interaface to gather all UIImageView targeted styles
public protocol ImageViewStyling: Styling {}

// MARK: - ImageView Styles
extension Styles {
    
    /// Base ImageView style
    public struct ImageView: ImageViewStyling {
        
        /// Possible properties of a ImageView.Style
        ///
        /// - image
        public enum Property {
            case image(UIImage)
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
            case let target as UIImageView:
                apply(to: target)
            default:
                print(SpiffyError.couldNotApply(style: "\(self)", to: "\(target)").description)
            }
        }
        
        private func apply(to target: UIImageView) {
            properties.forEach { property in
                switch property {
                case let .image(image):
                    target.image = image
                }
            }
        }
    }
}
