//
//  IPaProgressObservable.swift
//  IPaIndicator
//
//  Created by IPa Chen on 2020/4/19.
//

import UIKit
import Combine
import IPaDownloadManager
import IPaURLResourceUI
@available(iOS 13.0, *)
public protocol IPaProgressObservable: NSObject {
    func progressPublisher() -> AnyPublisher<Double,Never>
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
@available(iOS 13.0, *)
extension IPaURLRequestTaskOperation:IPaProgressObservable {
    
    public func progressPublisher() -> AnyPublisher<Double,Never> {
        return self.publisher(for: \.progress).eraseToAnyPublisher()
    }
    
}
@available(iOS 13.0, *)
extension IPaDownloadOperation:IPaProgressObservable {
    
    public func progressPublisher() -> AnyPublisher<Double,Never> {
        return self.publisher(for: \.progress).eraseToAnyPublisher()
    }
    
}
