//
//  ImageViewStyleTests.swift
//  SpiffyTests
//
//  Created by Balazs Hajagos on 2019. 04. 12..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

import Nimble
import UIKit
import Quick

@testable import Spiffy

final class ImageViewStyleTests: QuickSpec {
    override func spec() {
        describe("an imageview") {
            var target: UIImageView!
            
            beforeEach {
                target = UIImageView()
            }
            
            describe("styled by a style") {
                var style: Styling!
                
                context("that modifies it's image") {
                    it("changes alignment according to the style") {
                        guard let image = UIImage(named: "test", in: Bundle(for: ImageViewStyleTests.self), compatibleWith: nil) else {
                            XCTAssert(false, "test image not found")
                            return
                        }
                        style = Styles.ImageView(.image(image))
                        target.image = nil
                        target.styled(by: style)
                        expect(target.image).to(equal(image))
                    }
                }
            }
        }
    }
}
