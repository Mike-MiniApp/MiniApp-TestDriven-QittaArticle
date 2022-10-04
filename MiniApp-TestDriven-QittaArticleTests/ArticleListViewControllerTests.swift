//
//  ArticleListViewControllerTests.swift
//  MiniApp-TestDriven-QittaArticleTests
//
//  Created by 近藤米功 on 2022/10/04.
//

import XCTest
@testable import MiniApp_TestDriven_QittaArticle

final class ArticleListViewControllerTests: XCTestCase {

    func test_タイトルが表示されていること() {
        let article = Article(title: "記事タイトル")
        let client = FakeArticleListAPIClient(fakeResponse: [article])
        let vc = ArticleListViewController(client: client)
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        guard let cell = vc.tableView.dataSource?.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ArticleListCell else { XCTFail()
            return }
        XCTAssertEqual(cell.titleLabel.text, "記事タイトル")
    }

    func test_タイトルが表示されていること2() {
        let article = Article(title: "記事タイトル2")
        let client = FakeArticleListAPIClient(fakeResponse: [article])
        let vc = ArticleListViewController(client: client)
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        XCTAssertEqual(vc.titleLabel.text, "記事タイトル2")
    }
}

class FakeArticleListAPIClient: ArticleListAPIClientProtocol {
    let fakeResponse: [Article]

    init(fakeResponse: [Article]) {
        self.fakeResponse = fakeResponse
    }
    func fetch(completion: @escaping (([MiniApp_TestDriven_QittaArticle.Article]?) -> Void)) {
        completion(fakeResponse)
    }
}
