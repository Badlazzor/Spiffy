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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardShadowView: UIView!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    private let exampleLongString = "Nulla venenatis lacus ipsum, at luctus libero faucibus in. In efficitur egestas nisl, non finibus metus congue tempor. Nunc sodales ipsum vel lacus ultrices bibendum eu ac leo. Nam at pharetra mi. Nullam iaculis mollis suscipit. Morbi sodales diam blandit, pretium quam vitae, maximus enim. Pellentesque porta lectus sed felis dignissim malesuada. Quisque sed mauris sed nisl rutrum imperdiet. Nam vel nisl semper, vehicula libero."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
        apply(theme: Themes.Showcase.appleish)
        
        segmentedControl.addTarget(self, action: #selector(ViewController.themeSelected(_:)), for: .valueChanged)
    }
    
    @objc
    private func themeSelected(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            apply(theme: Themes.Showcase.flat, animated: true)
        default:
            apply(theme: Themes.Showcase.appleish, animated: true)
        }
    }
    
    private func fillData() {
        titleLabel.text = "Title"
        cardLabel.text = exampleLongString
        noteLabel.text = exampleLongString
        button1.setTitle("Decline", for: .normal)
        button2.setTitle("Accept", for: .normal)
    }
    
    private func apply<T: Theming>(theme: T, animated: Bool) where T.Key == Themes.Showcase.Key {
        guard animated else {
            apply(theme: theme)
            return
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.apply(theme: theme)
        }
    }
    
    private func apply<T: Theming>(theme: T) where T.Key == Themes.Showcase.Key {
        titleLabel.themed(as: .title, from: theme)
        cardView.themed(as: .card, from: theme)
        cardShadowView.themed(as: .cardShadow, from: theme)
        cardImage.themed(as: .icon, from: theme)
        cardLabel.themed(as: .body, from: theme)
        noteLabel.themed(as: .footnote, from: theme)
        button1.themed(as: .buttonDecline, from: theme)
        button2.themed(as: .buttonAccept, from: theme)
    }
}

fileprivate extension Themes {
    enum Showcase {
        enum Key {
            case title
            case body
            case footnote
            
            case card
            case cardShadow
            case icon
            
            case buttonAccept
            case buttonDecline
        }
        
        static let appleish = Theme<Key>(styleMap: [
            .title: Styles.Label(
                .alignment(.left),
                .font(.preferredFont(forTextStyle: .title1)),
                .color(.black)
            ),
            
            .body: Styles.Label(
                .font(.preferredFont(forTextStyle: .body)),
                .color(.black)
            ),
            
            .footnote: Styles.Label(
                .font(.preferredFont(forTextStyle: .footnote)),
                .color(.lightGray)
            ),
            
            .card: Styles.View(
                .backgroundColor(.white),
                .rounding(.explicit(20.0))
            ),
            
            .cardShadow: Styles.View(
                .backgroundColor(.clear),
                .shadow(opacity: 0.7, radius: 12.0, offset: CGSize(width: 0.0, height: 0.0), color: .gray)
            ),
            
            .icon: [
                Styles.ImageView(.image(#imageLiteral(resourceName: "apple"))),
                Styles.View(.contentMode(.scaleAspectFit))
            ],
            
            .buttonAccept: [
                Styles.Button(
                    .titleColor(with: .white, for: .normal),
                    .backgroundColor(with: .blue, for: .normal)
                ),
                Styles.View(
                    .rounding(.explicit(22.0))
                )
            ],
            
            .buttonDecline: [
                Styles.Button(
                    .titleColor(with: .white, for: .normal),
                    .backgroundColor(with: .red, for: .normal)
                ),
                Styles.View(
                    .rounding(.explicit(22.0))
                )
            ],
        ])
        
        static let flat = Theme<Key>(styleMap: [
            .title: Styles.Label(
                .alignment(.center),
                .font(.systemFont(ofSize: 34.0, weight: .light)),
                .color(.rgba(48, 51, 107, 1.0))
            ),
            
            .body: Styles.Label(
                .font(.systemFont(ofSize: 16.0, weight: .light)),
                .color(.rgba(48, 51, 107, 1.0))
            ),
            
            .footnote: Styles.Label(
                .font(.systemFont(ofSize: 14.0, weight: .light)),
                .color(.rgba(149, 175, 192, 1.0))
            ),
            
            .card: Styles.View(
                .backgroundColor(.rgba(223, 249, 251, 1.0)),
                .rounding(.explicit(8.0))
            ),
            
            .cardShadow: Styles.View(
                .backgroundColor(.clear),
                .shadow(opacity: 0.0, radius: 0.0, offset: CGSize(width: 0.0, height: 0.0), color: nil)
            ),
            
            .icon: [
                Styles.ImageView(.image(#imageLiteral(resourceName: "apple_flat"))),
                Styles.View(.contentMode(.scaleAspectFit))
            ],
            
            .buttonAccept: [
                Styles.Button(
                    .titleColor(with: .white, for: .normal),
                    .backgroundColor(with: .rgba(104, 109, 224, 1.0), for: .normal),
                    .backgroundColor(with: .rgba(72, 52, 212, 1.0), for: .highlighted)
                ),
                Styles.View(
                    .rounding(.explicit(8.0))
                )
            ],
            
            .buttonDecline: [
                Styles.Button(
                    .titleColor(with: .white, for: .normal),
                    .backgroundColor(with: .rgba(255, 121, 121, 1.0), for: .normal),
                        .backgroundColor(with: .rgba(235, 77, 75, 1.0), for: .highlighted)
                ),
                Styles.View(
                    .rounding(.explicit(8.0))
                )
            ],
        ])
    }
}

extension UIColor {
    static func rgba(_ r: Int, _ g: Int, _ b: Int, _ a: Float) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }
}
