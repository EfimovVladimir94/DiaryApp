//
//  NetworkManager.swift
//  DiaryApp
//
//  Created by Пользователь on 28.01.2021.
//

import Network


class NetworkManager {
    typealias completionHandler = (_ success: Bool) -> Void
    
    public static func monitorNetwork(completionHandler: @escaping completionHandler) {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    print("internet active")
                    completionHandler(true)
                }
            } else {
                DispatchQueue.main.async {
                    print("internet inactive")
                    completionHandler(false)
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}
