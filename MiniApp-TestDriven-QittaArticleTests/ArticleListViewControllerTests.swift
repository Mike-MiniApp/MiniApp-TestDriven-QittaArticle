//
//  ArticleListViewControllerTests.swift
//  MiniApp-TestDriven-QittaArticleTests
//
//  Created by 近藤米功 on 2022/10/04.
//

import XCTest
import SafariServices
@testable import MiniApp_TestDriven_QittaArticle

final class ArticleListViewControllerTests: XCTestCase {

    var vc: ArticleListViewController!

    override func setUp() {
        let article = Article(title: "記事タイトル", url: "http://test")
        let client = FakeArticleListAPIClient(fakeResponse: [article])
        vc = ArticleListViewController(client: client)
    }

    func test_タイトルが表示されていること() {
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        guard let cell = vc.tableView.dataSource?.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ArticleListCell else { XCTFail()
            return }
        XCTAssertEqual(cell.titleLabel.text, "記事タイトル")
    }

    func test_記事をタップして詳細画面が表示されること() {
        let window = UIWindow()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        vc.tableView(vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(vc.presentedViewController is SFSafariViewController)
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
