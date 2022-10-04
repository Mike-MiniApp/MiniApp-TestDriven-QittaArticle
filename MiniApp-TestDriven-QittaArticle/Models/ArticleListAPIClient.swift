//
//  ArticleListAPIClient.swift
//  MiniApp-TestDriven-QittaArticle
//
//  Created by 近藤米功 on 2022/10/04.
//

import Foundation

class ArticleListAPIClient: ArticleListAPIClientProtocol {
    func fetch(completion: @escaping (([Article]?) -> Void)) {
        guard let url = URL(string: "https://qiita.com/api/v2/items") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            let articleList = try? JSONDecoder().decode([Article].self, from: data)
            DispatchQueue.main.async {
                completion(articleList)
            }
        }.resume()
    }
}
