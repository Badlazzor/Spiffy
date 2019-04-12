//
//  ViewController.swift
//  SpiffyShowcase
//
//  Created by Balazs Hajagos on 2019. 04. 12..
//  Copyright © 2019. Balazs Hajagos. All rights reserved.
//

import Spiffy
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    static let exampleLongString = "Multilined. Nulla venenatis lacus ipsum, at luctus libero faucibus in. In efficitur egestas nisl, non finibus metus congue tempor. Nunc sodales ipsum vel lacus ultrices bibendum eu ac leo. Nam at pharetra mi. Nullam iaculis mollis suscipit. Morbi sodales diam blandit, pretium quam vitae, maximus enim. Pellentesque porta lectus sed felis dignissim malesuada. Quisque sed mauris sed nisl rutrum imperdiet. Nam vel nisl semper, vehicula libero."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(createLabel(with: "Aligned").styled(by: Styles.Showcase.Label.alignment))
        stackView.addArrangedSubview(createLabel(with: "Colored").styled(by: Styles.Showcase.Label.color))
        stackView.addArrangedSubview(createLabel(with: "Custom font").styled(by: Styles.Showcase.Label.font))
        stackView.addArrangedSubview(createLabel(with: ViewController.exampleLongString).styled(by: Styles.Showcase.Label.lines))
        stackView.addArrangedSubview(createLabel(with: "Multiple propery change").styled(by: Styles.Showcase.Label.multi))
        stackView.addArrangedSubview(createLabel(with: "Combined styles").styled(by: Styles.Showcase.Label.combined))
    }
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
}

extension Styles {
    fileprivate enum Showcase {
        enum Label {
            static let alignment = Styles.Label.Style(.alignment(.center))
            static let color = Styles.Label.Style(.color(.red))
            static let font = Styles.Label.Style(.font(UIFont.boldSystemFont(ofSize: 22)))
            static let lines = Styles.Label.Style(.lines(0))
            
            static let multi = Styles.Label.Style(
                .alignment(.right),
                .color(.blue)
            )
            
            static let combined: [Styling] = [
                alignment,
                color,
                Styles.Label.Style(.font(UIFont.systemFont(ofSize: 40, weight: .light)))
            ]
        }
    }
}
