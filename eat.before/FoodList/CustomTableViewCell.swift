//
//  CustomTableViewCell.swift
//  eat.before
//
//  Created by Дарья Тимофеева on 27.06.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var uiImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var foodNameLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "customCell")
        createConstraints()
    }
    
//    init() {
//
//        super.init(style: .default, reuseIdentifier: "customCell")
//        createConstraints()
//
//    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, uiImage: UIImage? = nil) {
        uiImageView.image = uiImage
        foodNameLabel.text = text
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
            foodNameLabel.centerYAnchor.constraint(equalTo: uiImageView.centerYAnchor),
            foodNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
