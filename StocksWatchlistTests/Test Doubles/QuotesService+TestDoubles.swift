//
//  QuotesService+TestDoubles.swift
//  StocksWatchlistTests
//
//  Created by Fernando Pena on 2/23/22.
//

import Foundation
@testable import StocksWatchlist

struct DummyQuotesService: QuotesService {
    func getQuotes(symbols: [String], completion: @escaping (Result<[Stock], Error>) -> Void) {
        completion(.success([]))
    }
}

class QuotesServiceSpy: QuotesService {
    private (set) var quoteCalls: [[String]] = []
    private let stocks: [Stock]
    private let error: Error?
    
    init(stocks: [Stock] = [], error: Error? = nil) {
        self.stocks = stocks
        self.error = error
    }
    
    func getQuotes(symbols: [String], completion: @escaping (Result<[Stock], Error>) -> Void) {
        quoteCalls.append(symbols)
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(stocks))
        }
    }
}
