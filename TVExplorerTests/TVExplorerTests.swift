//
//  TVExplorerTests.swift
//  TVExplorerTests
//
//  Created by Daniel Alvarez on 01/03/23.
//

import XCTest
@testable import TVExplorer

let mockShowData = [ResultItem(show: Show(id: 1, url: "", name: "Show1")),
                    ResultItem(show: Show(id: 2, url: "", name: "Show2")),
                    ResultItem(show: Show(id: 3, url: "", name: "Show3"))]

let mockAliasesData = [Alias(name: "Name1"),
                       Alias(name: "Name2"),
                       Alias(name: "Name3")]

class MockNetworkService: NetworkService {
    override func fetchShows(query: String) async throws -> [ResultItem] {
        return mockShowData
    }
    
    override func fetchAliases(showId: Int) async throws -> [Alias] {
        return mockAliasesData
    }
}

final class TVExplorerTests: XCTestCase {
    
    @MainActor func testLoadShows() async  {
        let mockNetworkService = MockNetworkService()
        let viewModel = ShowsViewModel(networkService: mockNetworkService)
        await viewModel.loadShows()
        XCTAssertEqual(3, viewModel.shows.count)
        XCTAssertEqual(mockShowData.first?.show.name, viewModel.shows.first?.show.name)
        XCTAssertEqual(mockShowData.last?.show.name, viewModel.shows.last?.show.name)
    }
    
    @MainActor func testLoadAliases() async  {
        let mockNetworkService = MockNetworkService()
        let viewModel = ShowsViewModel(networkService: mockNetworkService)
        await viewModel.loadAlias(showId: 1)
        XCTAssertEqual("Name1, Name2, Name3", viewModel.currentShowAliases)
    }
    
}
