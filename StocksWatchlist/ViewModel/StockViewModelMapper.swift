//
//  StockViewModelMapper.swift
//  StocksWatchlist
//
//  Created by Fernando Pena on 2/23/22.
//

import Foundation

struct StockViewModelMapper {
    static func map(symbol: String) -> StockViewModel {
        StockViewModel(
            symbol: symbol,
            price: "-",
            percentChange: "-")
    }
    
    static func map(stock: Stock) -> StockViewModel {
        if let quote = stock.quote {
            return StockViewModel(
                symbol: stock.symbol,
                price: String(format: "%.2f", quote.last),
                percentChange: String(format: "%.2f", quote.percentChange) + " %")
        } else {
            return map(symbol: stock.symbol)
        }
   }
}
