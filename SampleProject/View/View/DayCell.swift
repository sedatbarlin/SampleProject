//
//  DayCell.swift
//  SampleProject
//
//  Created by Sedat on 21.10.2024.
//

import UIKit
import SnapKit

class DayCell: UITableViewCell {
    
    static let identifier = "DayCell"
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.image = UIImage(systemName: "chevron.down")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .purple
        arrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    func configure(with section: DaySection) {
        titleLabel.text = section.title
        arrowImageView.image = UIImage(systemName: section.isExpanded ? "chevron.up" : "chevron.down")
    }
}
