//
//  URLSessionTask+IPaProgressObservable.swift
//  IPaIndicator
//
//  Created by IPa Chen on 2020/4/20.
//

import UIKit

extension URLSessionTask:IPaProgressObservable {
    public func observeProgress(_ handler: @escaping (IPaProgressObservable,CGFloat) -> ()) -> NSKeyValueObservation {
        return self.progress.observe(\.fractionCompleted) { (progress,_) in
            handler(self,CGFloat(progress.fractionCompleted))
        }
    }
    
    public func observeComplete(_ handler: @escaping (IPaProgressObservable) -> ()) -> NSKeyValueObservation {
        return self.observe(\.state) {
            (task,_) in
            if task.state == .canceling || task.state == .completed {
                handler(self)
            }
        }
    }
    
    public var isProgressing: Bool {
        get {
            return self.state != .canceling || self.state != .completed;
        }
    }
}
