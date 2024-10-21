//
//  CategoryCell.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    private let titleLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    private func setupUI(){
        contentView.addSubview(titleLabel)
        
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configure(with category: Category) {
        titleLabel.text = category.title
    }
    
    func setSelected(_ selected: Bool) {
        if selected {
            contentView.layer.insertSublayer(gradientLayer, at: 0)
            titleLabel.textColor = .white
        } else {
            gradientLayer.removeFromSuperlayer()
            titleLabel.textColor = .black
        }
    }
}
