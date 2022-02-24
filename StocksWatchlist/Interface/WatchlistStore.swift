//
//  WatchlistStore.swift
//  StocksWatchlist
//
//  Created by Fernando Pena on 2/23/22.
//

import Foundation

protocol WatchlistStore {
    func update(_ stockSymbols: [String]) throws
    func retrieve() throws -> [String]?
}
