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
fileprivate var AssociatedObjectHandle: UInt8 = 0
@available(iOS 13.0, *)
extension IPaProgressIndicator {
    var progressCancellable:AnyCancellable?
    {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? AnyCancellable
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    open class func show(_ inView:UIView,target:IPaProgressObservable) -> IPaProgressIndicator {
        let indicator = self.show(inView)
        indicator.observer(target)
        return indicator
    }
    
    func observer(_ target:IPaProgressObservable) {
        self.progressCancellable = target.progressPublisher().sink(receiveValue: { progress in
            DispatchQueue.main.async {
                self.progress = progress
            }
        })
//        .assign(to: \.progress, on: self)
        
    }
}

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
