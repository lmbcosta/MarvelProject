//
//  DetailCell.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "DetailCell"
    
    let topLabel = UILabel(frame: .zero)
    let bottomLabel = UILabel(frame: .zero)
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        topLabel.text = nil
        bottomLabel.text = nil
    }
    
    // MARK: - Internal
    func setupContent(_ item: DetailItemProtocol) {
        topLabel.text = item.title
        bottomLabel.text = item.description
    }
    
    // MARK: - Private
    private func setupView() {
        setupTopLabel()
        setupBottomLabel()
    }
    
    private func setupTopLabel() {
        topLabel.font = Label.Top.font
        contentView.addSubview(topLabel)
        setupTopLabelConstraints()
    }
    
    private func setupTopLabelConstraints() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        ])
    }
    
    private func setupBottomLabel() {
        bottomLabel.font = Label.Bottom.font
        bottomLabel.numberOfLines = 0
        contentView.addSubview(bottomLabel)
        setupBottomLabelConstraints()
    }
    
    private func setupBottomLabelConstraints() {
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20),
            bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            bottomLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

private extension DetailCell {
    struct Dimensions {
        static let leading: CGFloat = 12
        static let trailing: CGFloat = 12
        static let top: CGFloat = 20
        static let bottom: CGFloat = 20
    }
    
    struct Label {
        struct Top {
            static let font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        struct Bottom {
            static let font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
    }
}
