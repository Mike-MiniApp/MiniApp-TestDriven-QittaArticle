//
//  ArticleListCell.swift
//  MiniApp-TestDriven-QittaArticle
//
//  Created by 近藤米功 on 2022/10/04.
//

import UIKit

class ArticleListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "ArticleListCell"
    static let nibName = "ArticleListCell"

    func configure(title: String) {
        titleLabel.text = title
    }
}
