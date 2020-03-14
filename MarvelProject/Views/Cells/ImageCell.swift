//
//  ImageCell.swift
//  MarvelProject
//
//  Created by Luis  Costa on 13/03/2020.
//  Copyright © 2020 Luis  Costa. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCell: UITableViewCell {
    // MARK: - Pproperties
    static let reuseIdentifier = "ImageCell"
    private let thumbnail = UIImageView(frame: .zero)
    
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
        thumbnail.image = nil
    }
    
    // MARK: - Internal
    func setupContent(_ item: ImageItemProtocol) {
        guard let imgURL = item.url(for: .landscape) else { return }
        thumbnail.kf.setImage(with: imgURL, placeholder: Images.placeholder, options: [.transition(.fade(1))])
    }
    
    // MARK: - Private
    func setupView() {
        setupThumbnail()
    }
    
    private func setupThumbnail() {
        thumbnail.contentMode = .scaleAspectFill
        thumbnail.clipsToBounds = true
        contentView.addSubview(thumbnail)
        setupThumbnailConstraints()
    }
    
    private func setupThumbnailConstraints() {
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnail.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

private extension ImageCell {
    struct Images {
        static let placeholder = UIImage(named: "placeholder")!
    }
}
