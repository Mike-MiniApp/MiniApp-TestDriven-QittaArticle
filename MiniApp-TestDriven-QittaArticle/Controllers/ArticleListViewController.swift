//
//  ArticleListViewController.swift
//  MiniApp-TestDriven-QittaArticle
//
//  Created by 近藤米功 on 2022/10/04.
//

import UIKit
import SafariServices

class ArticleListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var items = [Article]()

    let client: ArticleListAPIClientProtocol
    
    init(client: ArticleListAPIClientProtocol = ArticleListAPIClient()) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: ArticleListCell.nibName, bundle: nil), forCellReuseIdentifier: ArticleListCell.identifier)

        client.fetch { [weak self] (articleList) in
            guard let articleList = articleList,0<articleList.count else { return }
            self?.items = articleList
            self?.tableView.reloadData()
        }
    }
}

extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListCell.identifier, for: indexPath) as? ArticleListCell else { fatalError("The dequeued cell is not instance")}
        let article = items[indexPath.row]
        cell.configure(title: article.title)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: items[indexPath.row].url)else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController,animated: true,completion: nil)
    }
}

