//
//  IPaProgressObservable.swift
//  IPaIndicator
//
//  Created by IPa Chen on 2020/4/19.
//

import UIKit

public protocol IPaProgressObservable: NSObject {
    var isProgressing:Bool { get }
    func observeProgress(_ handler:@escaping (IPaProgressObservable,CGFloat)->())-> NSKeyValueObservation
    func observeComplete(_ handler:@escaping (IPaProgressObservable)->())->NSKeyValueObservation
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
