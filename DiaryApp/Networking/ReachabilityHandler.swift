//
//  ReachabilityHandler.swift
//  DiaryApp
//
//  Created by Пользователь on 26.01.2021.
//

import Foundation
class ReachabilityHandler: ReachabilityObserverDelegate {
    
    var connect = true
    
    
    //MARK: Lifecycle
    
    required init() {
        try? addReachabilityObserver()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    //MARK: Reachability
    
    func reachabilityChanged(_ isReachable: Bool) {
        if !isReachable {
            connect = false
            print("No internet connection")
        }
    }
}
