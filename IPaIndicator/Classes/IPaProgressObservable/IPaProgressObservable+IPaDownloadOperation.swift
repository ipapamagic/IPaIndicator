//
//  IPaProgressObservable+IPaDownloadOperation.swift
//  IPaIndicator
//
//  Created by IPa Chen on 2020/4/20.
//

import UIKit
import IPaDownloadManager
extension IPaDownloadOperation: IPaProgressObservable {
    public var isProgressing: Bool {
        return self.isExecuting
    }
    
    public func observeProgress(_ handler: @escaping (IPaProgressObservable,CGFloat) -> ()) -> NSKeyValueObservation {
        return self.observe(\.progress) {
            (operation,_) in
            handler(operation,CGFloat(operation.progress))
        }
    }
    
    public func observeComplete(_ handler: @escaping (IPaProgressObservable) -> ()) -> NSKeyValueObservation {
        return self.observe(\.isFinished) {
            (operation,_) in
            if operation.isFinished {
                handler(operation)
            }
        }
    }
    

}
