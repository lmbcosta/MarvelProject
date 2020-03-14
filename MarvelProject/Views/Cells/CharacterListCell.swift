//
//  CharacterListCell.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterListCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "CharacterListCell"
    
    private let thumbnail = UIImageView(frame: .zero)
    private let label = UILabel(frame: .zero)
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    func setupContent(_ item: CharacterListItemProtocol) {
        label.text = item.text
        guard let imageURL = item.url(for: .square) else { return }
        thumbnail.kf.setImage(with: imageURL,
                              placeholder: Images.placeholder,
                              options: [.transition(.fade(1))])
    }
    
    override func layoutSubviews() {
        thumbnail.layer.masksToBounds = true
        thumbnail.layer.cornerRadius = thumbnail.frame.height / 2
        super.layoutSubviews()
    }
    
    // MARK: - Private
    func setupView() {
        setupThumnail()
        setupLabel()
    }
    
    func setupThumnail() {
        contentView.addSubview(thumbnail)
        setupThumnailConstraints()
    }
    
    func setupThumnailConstraints() {
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Dimensions.Thumbnail.leading),
            thumbnail.heightAnchor.constraint(equalToConstant: Dimensions.Thumbnail.side),
            thumbnail.widthAnchor.constraint(equalToConstant: Dimensions.Thumbnail.side)
        ])
    }
    
    func setupLabel() {
        label.textAlignment = .left
        label.font = Font.label
        contentView.addSubview(label)
        setupLabelConstraints()
    }
    
    func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: Dimensions.Label.leading),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Dimensions.Label.trailing)
        ])
    }
}

private extension CharacterListCell {
    struct Images {
        static let placeholder = UIImage(named: "placeholder")!
    }
    
    struct Dimensions {
        struct Thumbnail {
            static let leading: CGFloat = 22
            static let side: CGFloat = 40
        }
        
        struct Label {
            static let leading: CGFloat = 22
            static let trailing: CGFloat = 12
        }
    }
    
    struct Font {
        static let label = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
}
