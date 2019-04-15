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
    
    var sizeChangeHandlers: [() -> Void] = []
    
    static let exampleLongString = "Multilined. Nulla venenatis lacus ipsum, at luctus libero faucibus in. In efficitur egestas nisl, non finibus metus congue tempor. Nunc sodales ipsum vel lacus ultrices bibendum eu ac leo. Nam at pharetra mi. Nullam iaculis mollis suscipit. Morbi sodales diam blandit, pretium quam vitae, maximus enim. Pellentesque porta lectus sed felis dignissim malesuada. Quisque sed mauris sed nisl rutrum imperdiet. Nam vel nisl semper, vehicula libero."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.styled(by: Styles.Showcase.StackView.base)
        
        // MARK: Add labels
        stackView.addArrangedSubview(createLabel(with: "Aligned").styled(by: Styles.Showcase.Label.alignment))
        stackView.addArrangedSubview(createLabel(with: "Colored").styled(by: Styles.Showcase.Label.color))
        stackView.addArrangedSubview(createLabel(with: "Custom font").styled(by: Styles.Showcase.Label.font))
        stackView.addArrangedSubview(createLabel(with: ViewController.exampleLongString).styled(by: Styles.Showcase.Label.lines))
        stackView.addArrangedSubview(createLabel(with: "Multiple propery change").styled(by: Styles.Showcase.Label.multi))
        stackView.addArrangedSubview(createLabel(with: "Combined styles").styled(by: Styles.Showcase.Label.combined))
        
        // MARK: Add buttons
        stackView.addArrangedSubview(
            createButtonShadow(with:
                createButton(with: "Colored")
                    .styled(by: Styles.Showcase.Button.titleColorForNormal)
        ))
        stackView.addArrangedSubview(
            createButtonShadow(with:
                createButton(with: "Highlight Colored")
                    .styled(by: Styles.View.RoundingStyle(.dynamic(type: .full, axis: .horizontal, with: self)))
                    .styled(by: Styles.Showcase.Button.titleColorForPressed)
        ))
    }
    
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        return label
    }
    
    private func createButton(with text: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(text, for: .normal)
        button.adjustsImageWhenHighlighted = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        return button
    }
    
    private func createButtonShadow(with button: UIButton) -> UIView {
        let view = UIView().styled(by: Styles.Showcase.Button.buttonShadow)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        return view
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeChangeHandlers.forEach { $0() }
    }
}

extension ViewController: ViewRoundingDynamicSizeProvider {
    func registerDynamicSizeChangeAction(for view: UIView, action: @escaping (CGSize) -> Void) {
        sizeChangeHandlers.append({ [weak view] in
            guard let size = view?.bounds.size else { return }
            action(size)
        })
    }
}

extension Styles {
    fileprivate enum Showcase {
        enum StackView {
            static let base = Styles.View.Style(.backgroundColor(.clear))
        }
        
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
        
        enum Button {
            static let titleColorForNormal: [Styling] = [
                Styles.View.Predefined.autolayouted,
                Styles.Button.Style(
                    .titleColor(with: .red, for: .normal),
                    .backgroundColor(with: .gray, for: .normal)
                ),
                Styles.View.RoundingStyle(.explicit(4.0))
            ]
            static let titleColorForPressed: [Styling] = [
                Styles.View.Predefined.autolayouted,
                Styles.Button.Style(
                    .titleColor(with: .black, for: .normal),
                    .backgroundColor(with: .white, for: .normal),
                    .titleColor(with: .red, for: .highlighted),
                    .backgroundColor(with: .gray, for: .highlighted)
                )
            ]
            static let buttonShadow =  Styles.View.Style(
                .autolayouted(true),
                .backgroundColor(.clear),
                .shadow(opacity: 0.2, radius: 8.0, offset: CGSize(width: 0, height: 2), color: .black)
            )
        }
    }
}
