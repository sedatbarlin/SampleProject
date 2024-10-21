//
//  DetailCell.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import UIKit
import SnapKit

class DetailCell: UITableViewCell {
    
    static let identifier = "DetailCell"
    private let backgroundCardView = UIView()
    private let gradientLayer = CAGradientLayer()
    private let speakerLabel = UILabel()
    private let speakerNameLabel = UILabel()
    private let subheadingLabel = UILabel()
    private let stageLabel = UILabel()
    private let timeLabel = UILabel()
    private let stageIcon = UIImageView()
    private let timeIcon = UIImageView()
    private let plusButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = backgroundCardView.bounds
    }
    
    private func setupUI() {
        backgroundCardView.layer.cornerRadius = 20
        backgroundCardView.layer.masksToBounds = true
        contentView.addSubview(backgroundCardView)
        backgroundCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        backgroundCardView.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        speakerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        speakerLabel.text = "Speaker"
        speakerLabel.textColor = .white
        backgroundCardView.addSubview(speakerLabel)
        speakerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        speakerNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        speakerNameLabel.textColor = .white
        speakerNameLabel.numberOfLines = 2
        backgroundCardView.addSubview(speakerNameLabel)
        speakerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundCardView.snp.top)
            make.leading.equalTo(speakerLabel.snp.trailing).offset(20)
            make.trailing.equalTo(backgroundCardView).offset(-20)
        }
        
        subheadingLabel.font = UIFont.systemFont(ofSize: 14)
        subheadingLabel.textColor = .white
        subheadingLabel.numberOfLines = 1
        backgroundCardView.addSubview(subheadingLabel)
        subheadingLabel.snp.makeConstraints { make in
            make.leading.equalTo(speakerNameLabel)
            make.top.equalTo(speakerNameLabel.snp.bottom).offset(4)
        }
        
        stageIcon.image = UIImage(systemName: "mappin.and.ellipse")
        stageIcon.tintColor = .white
        backgroundCardView.addSubview(stageIcon)
        stageIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(subheadingLabel.snp.bottom).offset(16)
            make.width.height.equalTo(20)
        }
        
        stageLabel.font = UIFont.systemFont(ofSize: 12)
        stageLabel.text = "Main Stage"
        stageLabel.textColor = .white
        backgroundCardView.addSubview(stageLabel)
        stageLabel.snp.makeConstraints { make in
            make.leading.equalTo(stageIcon.snp.trailing).offset(8)
            make.centerY.equalTo(stageIcon)
        }
        
        timeIcon.image = UIImage(systemName: "clock")
        timeIcon.tintColor = .white
        backgroundCardView.addSubview(timeIcon)
        timeIcon.snp.makeConstraints { make in
            make.leading.equalTo(stageLabel.snp.trailing).offset(50)
            make.centerY.equalTo(stageIcon)
            make.width.height.equalTo(20)
        }
        
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .white
        backgroundCardView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(timeIcon.snp.trailing).offset(8)
            make.centerY.equalTo(timeIcon)
        }
        
        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.tintColor = .white
        plusButton.contentMode = .scaleAspectFit
        backgroundCardView.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    func configure(with detail: DetailInfo) {
        speakerNameLabel.text = detail.title
        subheadingLabel.text = detail.stage
        timeLabel.text = detail.time ?? "13:30 - 13:40"
        stageLabel.text = detail.stage
    }
}
