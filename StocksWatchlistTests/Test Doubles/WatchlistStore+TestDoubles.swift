//
//  WatchlistStore+TestDoubles.swift
//  StocksWatchlistTests
//
//  Created by Fernando Pena on 2/23/22.
//

import Foundation
@testable import StocksWatchlist

struct DummyWatchlistStore: WatchlistStore {
    func update(_ stockSymbols: [String]) throws { }
    func retrieve() throws -> [String]? { [] }
}

class WatchlistStoreStub: WatchlistStore {
    private let stockSymbols: [String]?
    private let updateError: Error?
    private let retrieveError: Error?

    init(stockSymbols: [String]? = nil, updateError: Error? = nil, retrieveError: Error? = nil) {
        self.stockSymbols = stockSymbols
        self.updateError = updateError
        self.retrieveError = retrieveError
    }
    
    func update(_ stockSymbols: [String]) throws {
        if let error = updateError {
            throw error
        }
    }
    
    func retrieve() throws -> [String]? {
        if let error = retrieveError {
            throw error
        } else {
            return stockSymbols
        }
    }
}

class FakeWatchlistStore: WatchlistStore {
    private var stockSymbols: [String]?
    
    func update(_ stockSymbols: [String]) {
        self.stockSymbols = stockSymbols
    }
    
    func retrieve() -> [String]? {
        stockSymbols
    }
}
