//
//  WatchlistViewModelTests.swift
//  StocksWatchlistTests
//
//  Created by Fernando Pena on 2/23/22.
//

import XCTest
@testable import StocksWatchlist

class WatchlistViewModelTests: XCTestCase {
    func test_init_stateIsClear() {
        let sut = WatchlistViewModel(store: DummyWatchlistStore(), service: DummyQuotesService())
        
        XCTAssertEqual(sut.title, "Watchlist")
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
        XCTAssertNil(sut.stockViewModels)
    }
    
    func test_getWatchlistWithoutStoreSymbols_generatesEmptyList() {
        let sut = WatchlistViewModel(store: WatchlistStoreStub(stockSymbols: []), service: DummyQuotesService())
        sut.getWatchlist()
        XCTAssertEqual(sut.stockViewModels, [])
    }
    
    func test_getWatchlistWithStoreRetrieveError_generatesErrorMessage() {
        let sut = WatchlistViewModel(store: WatchlistStoreStub(retrieveError: AnyError()), service: DummyQuotesService())
        sut.getWatchlist()
        XCTAssertNotNil(sut.errorMessage)
    }
    
    func test_getWatchlistWithSymbols_callGetQuotes() {
        let stockSymbols = ["AAPL", "MSFT", "GOOG"]
        let watchlistStore = WatchlistStoreStub(stockSymbols: stockSymbols)
        let quotesService = QuotesServiceSpy()

        let sut = WatchlistViewModel(store: watchlistStore, service: quotesService)
        sut.getWatchlist()

        XCTAssertEqual(quotesService.quoteCalls[0], stockSymbols)
    }
    
    func test_whenStoreIsUpdatedAndQuotesServiceFails_symbolsAreUpdated() {
        let watchlistStore = FakeWatchlistStore()
        let quotesService = QuotesServiceSpy(error: AnyError())
        let sut = WatchlistViewModel(store: watchlistStore, service: quotesService)
        
        watchlistStore.update(["AAPL"])
        sut.getWatchlist()
        
        XCTAssertEqual(sut.stockViewModels?.count, 1)
        XCTAssertEqual(sut.stockViewModels?[0].symbol, "AAPL")
        
        watchlistStore.update(["AAPL", "MSFT"])
        sut.getWatchlist()
        
        XCTAssertEqual(sut.stockViewModels?.count, 2)
        XCTAssertEqual(sut.stockViewModels?[0].symbol, "AAPL")
        XCTAssertEqual(sut.stockViewModels?[1].symbol, "MSFT")
    }
}


struct AnyError: Error {}
