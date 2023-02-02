//
//  SpoiledFoodTableViewCell.swift
//  eat.before
//
//  Created by Дарья Тимофеева on 08.07.2022.
//

import UIKit


class SpoiledFoodTableViewCell: UITableViewCell {
    
    private lazy var uiImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var foodNameLabel: UILabel = UILabel()
    private lazy var spoiledLabel: UILabel = {
        let label = UILabel()
        label.text = "spoiled"
        label.textColor = .white
        label.backgroundColor = .systemRed
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "spoiledFoodCustomCell")
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, uiImage: UIImage? = nil, spoiled: String = "spoiled") {
        uiImageView.image = uiImage
        foodNameLabel.text = text
        spoiledLabel.text = spoiled
    }
    
    func getTitle() -> String {
        return foodNameLabel.text ?? ""
    }
    
    private func createConstraints() {
        
        contentView.addSubview(uiImageView)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            uiImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            uiImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            uiImageView.widthAnchor.constraint(equalToConstant: 60),
            uiImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        contentView.addSubview(foodNameLabel)
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodNameLabel.leadingAnchor.constraint(equalTo: uiImageView.trailingAnchor, constant: 16),
            foodNameLabel.centerYAnchor.constraint(equalTo: uiImageView.centerYAnchor)
        ])
        
        contentView.addSubview(spoiledLabel)
        spoiledLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spoiledLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            spoiledLabel.centerYAnchor.constraint(equalTo: uiImageView.centerYAnchor)
            
        ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

