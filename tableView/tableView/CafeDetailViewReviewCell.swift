//
//  CafeDetailViewReviewCell.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/19.
//

import Foundation

import UIKit

class CafeDetailViewReviewCell: UITableViewCell {
    var stars: [UIImageView] = []

    private let star: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        if let coffeeImage = UIImage(named: "coffee1") {
            image.image = coffeeImage
        }
        
        return image
    }()

    
    private let nickname: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "화양동뚜벅초"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let hour: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "3시간전"
        label.numberOfLines = 1
        
        return label
    }()
    
    private let review: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "카페분위기가 좋아요"
        label.numberOfLines = 0 // 자동으로 줄 수 결정

        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        // 셀의 설정을 수행합니다.
        backgroundColor = .white
    }

    private func addSubviews() {
        // 셀에 서브뷰들을 추가합니다.
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor =  UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
        contentView.layer.cornerRadius = 10        
        contentView.clipsToBounds = true
        
        // 그림자 효과를 위한 설정
//        self.layer.shadowColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowOffset = CGSize(width: 0, height: 2)
//        self.layer.shadowRadius = 4

        contentView.addSubview(nickname)
        contentView.addSubview(hour)
        contentView.addSubview(review)
    }
    

    private func setupLayout() {
        // 서브뷰들의 레이아웃을 설정합니다.
        nickname.translatesAutoresizingMaskIntoConstraints = false
        hour.translatesAutoresizingMaskIntoConstraints = false
        review.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            nickname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nickname.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),

            hour.leadingAnchor.constraint(equalTo: nickname.trailingAnchor, constant: 20),
            hour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            review.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            review.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 6),
            //review.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
  
        ])
    }

    func configure(nickname: String, hour: String, review: String) {
        // 셀의 내용을 설정합니다.
        self.nickname.text = nickname
        self.hour.text = hour
        self.review.text = review
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 10, right: 20))
    }
}
