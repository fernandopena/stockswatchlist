//
//  WatchlistViewModel.swift
//  StocksWatchlist
//
//  Created by Fernando Pena on 2/23/22.
//

import Foundation

class WatchlistViewModel {
    //Dependencies
    private let store: WatchlistStore
    private let service: QuotesService
  
    //Properties
    let title: String
    var isLoading: Bool
    var errorMessage: String?
    var stockViewModels: [StockViewModel]?

    //Initializer
    init(store: WatchlistStore, service: QuotesService, title: String = "Watchlist") {
        self.store = store
        self.service = service
        self.title = title
        self.isLoading = false
        self.errorMessage = nil
        self.stockViewModels = nil
    }
    
    func updateWatchlist(symbols: [String]) {
        try? store.update(symbols)
    }
    
    func getWatchlist() {
        do {
            if let symbols = try store.retrieve() {
                isLoading = true
                errorMessage = nil
                service.getQuotes(symbols: symbols) { [weak self] result in
                    self?.isLoading = false
                    switch result {
                    case .success(let stocks):
                        self?.stockViewModels = stocks.map { StockViewModelMapper.map(stock: $0) }
                    case .failure(_):
                        self?.stockViewModels = symbols.map { StockViewModelMapper.map(symbol: $0) }
                    }
                }
            }
        } catch {
            errorMessage = "Error while getting the watchlist from the store"
        }
    }
}
