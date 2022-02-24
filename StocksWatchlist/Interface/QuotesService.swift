//
//  QuotesService.swift
//  StocksWatchlist
//
//  Created by Fernando Pena on 2/23/22.
//

import Foundation

protocol QuotesService {
    func getQuotes(symbols: [String], completion: @escaping (Result<[Stock], Error>) -> Void)
}
