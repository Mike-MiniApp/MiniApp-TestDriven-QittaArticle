//
//  ArticleListAPIClientProtocol.swift
//  MiniApp-TestDriven-QittaArticle
//
//  Created by 近藤米功 on 2022/10/04.
//

import Foundation

protocol ArticleListAPIClientProtocol {
    func fetch(completion: @escaping(([Article]?) -> Void))
}
