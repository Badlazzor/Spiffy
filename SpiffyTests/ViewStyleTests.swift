//
//  ViewStyleTests.swift
//  StylingTests
//
//  Created by Balazs Hajagos on 2019. 04. 11..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

import Nimble
import UIKit
import Quick

@testable import Spiffy

final class ViewStyleTests: QuickSpec {
    override func spec() {
        describe("a view") {
            var view: UIView!
            
            beforeEach {
                view = UIView()
            }
            
            describe("styled by a style") {
                var style: Styling!
                
                context("that modifies it's alpha") {
                    beforeEach {
                        style = Styles.View.Style(.alpha(0.2))
                    }
                    
                    it("changes the alpha according to the style") {
                        view.alpha = 0
                        view.styled(by: style)
                        expect(view.alpha).to(beCloseTo(0.2))
                    }
                }
                
                context("that modifies it's autolayouted behviour") {
                    beforeEach {
                        style = Styles.View.Style(.autolayouted(true))
                    }
                    
                    it("changes translatesAutoresizingMaskIntoConstraints according to the style") {
                        view.translatesAutoresizingMaskIntoConstraints = false
                        view.styled(by: style)
                        expect(view.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    }
                }
                
                context("that modifies it's backgroundColor") {
                    beforeEach {
                        style = Styles.View.Style(.backgroundColor(.red))
                    }
                    
                    it("changes backgroundColor according to the style") {
                        view.backgroundColor = .blue
                        view.styled(by: style)
                        expect(view.backgroundColor).to(equal(.red))
                    }
                }
                
                context("that modifies it's contentMode") {
                    beforeEach {
                        style = Styles.View.Style(.contentMode(.scaleAspectFit))
                    }

                    it("changes contentMode according to the style") {
                        view.contentMode = .scaleAspectFill
                        view.styled(by: style)
                        expect(view.contentMode).to(equal(.scaleAspectFit))
                    }
                }
                
                context("that modifies it's layout priorities") {
                    beforeEach {
                        style = Styles.View.Style(.priority(.compressionResistance, .horizontal, 800))
                    }
                    
                    it("changes layout priorities according to the style") {
                        view.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
                        view.styled(by: style)
                        expect(view.contentCompressionResistancePriority(for: .horizontal)).to(equal(UILayoutPriority(rawValue: 800)))
                    }
                }
            }
            
            describe("styled by a collection of stlyes") {
                let styles: [Styling] = [
                    Styles.View.Style(.backgroundColor(.red)),
                    Styles.View.Style(
                        .backgroundColor(.yellow),
                        .contentMode(.scaleAspectFill)
                    ),
                    Styles.View.Style(
                        .contentMode(.scaleAspectFit),
                        .alpha(0.5)
                    ),
                    ]

                it("applies the styles one-by-one in the order they've been passed") {
                    view.backgroundColor = .blue
                    view.contentMode = .center
                    view.alpha = 1

                    view.styled(by: styles)

                    expect(view.backgroundColor).to(equal(.yellow))
                    expect(view.contentMode).to(equal(.scaleAspectFit))
                    expect(view.alpha).to(beCloseTo(0.5))
                }
            }
        }
    }
}
