//
//  LabelStyleTests.swift
//  SpiffyTests
//
//  Created by Balazs Hajagos on 2019. 04. 11..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

import Nimble
import UIKit
import Quick

@testable import Spiffy

final class LabelStyleTests: QuickSpec {
    override func spec() {
        describe("a label") {
            var label: UILabel!
            
            beforeEach {
                label = UILabel()
            }
            
            describe("styled by a style") {
                var style: Styling!
                
                context("that modifies the text alignment") {
                    beforeEach {
                        style = Styles.Label.Style(.alignment(.center))
                    }
                    
                    it("changes alignment according to the style") {
                        label.textAlignment = .left
                        label.styled(by: style)
                        expect(label.textAlignment).to(equal(.center))
                    }
                }
                
                context("that modifies the text font") {
                    beforeEach {
                        style = Styles.Label.Style(.font(UIFont.systemFont(ofSize: 20)))
                    }
                    
                    it("changes alignment according to the style") {
                        label.font = UIFont.systemFont(ofSize: 10)
                        label.styled(by: style)
                        expect(label.font.pointSize).to(equal(20))
                    }
                }
                
                context("that modifies the label's numberOfLines") {
                    beforeEach {
                        style = Styles.Label.Style(.lines(0))
                    }
                    
                    it("changes alignment according to the style") {
                        label.numberOfLines = 10
                        label.styled(by: style)
                        expect(label.numberOfLines).to(equal(0))
                    }
                }
                
                context("that modifies the text color") {
                    beforeEach {
                        style = Styles.Label.Style(.color(.red))
                    }
                    
                    it("changes alignment according to the style") {
                        label.textColor = .yellow
                        label.styled(by: style)
                        expect(label.textColor).to(equal(.red))
                    }
                }
            }
            
            describe("styled by a collection of stlyes") {
                let styles: [Styling] = [
                    Styles.Label.Style(.color(.red)),
                    Styles.Label.Style(
                        .color(.yellow),
                        .alignment(.center)
                    ),
                    Styles.Label.Style(
                        .alignment(.right),
                        .lines(2)
                    ),
                ]
                
                it("applies the styles one-by-one in the order they've been passed") {
                    label.textColor = .blue
                    label.textAlignment = .left
                    label.numberOfLines = 1
                    
                    label.styled(by: styles)
                    
                    expect(label.textColor).to(equal(.yellow))
                    expect(label.textAlignment).to(equal(.right))
                    expect(label.numberOfLines).to(equal(2))
                }
            }
        }
    }
}
