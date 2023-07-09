//
//  RateView.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/22.
//

import UIKit

class RateView: BaseView {

    var starNumber: Int = 5 {
        didSet { bind() }
    }
    var currentStar: Int = 0

    private var buttons: [UIButton] = []

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)

        return view
    }()

    
    lazy var starFillImage: UIImage? = {
        return UIImage(systemName: "star.fill",
                       withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    }()
    
    

    lazy var starEmptyImage: UIImage? = {
        return UIImage(systemName: "star",
                       withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    }()

    override func configure() {
        super.configure()

        starNumber = 5
        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -605).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 180).isActive = true
    }

    override func bind() {
        super.bind()

        for i in 0..<5 {
            let button = UIButton()
            button.setImage(starEmptyImage, for: .normal)
            button.tag = i
            buttons += [button]
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        }
    }

    @objc
    private func didTapButton(sender: UIButton) {
        let end = sender.tag

        for i in 0...end {
            buttons[i].setImage(starFillImage, for: .normal)
        }
        for i in end + 1..<starNumber {
            buttons[i].setImage(starEmptyImage, for: .normal)
        }

        currentStar = end + 1
    }
}


class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {}
    func bind() {}
}
