//
//  IPaActivityIndicator.swift
//  IPaActivityIndicator
//
//  Created by IPa Chen on 2015/7/4.
//  Copyright (c) 2015年 A Magic Studio. All rights reserved.
//

import Foundation
import UIKit

class IPaActivityIndicator: UIView {
    static var workingIndicators = [UIView:[IPaActivityIndicator]]()
    lazy var indicator = UIActivityIndicatorView(activityIndicatorStyle:.WhiteLarge)
    lazy var indicatorBackView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    convenience init(view:UIView) {
        self.init(frame: view.bounds)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }

    func initialSetting() {
        userInteractionEnabled = true
        backgroundColor = UIColor.clearColor()
        indicatorBackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        indicatorBackView.layer.cornerRadius = 10
        indicatorBackView.clipsToBounds = true
        indicator.setTranslatesAutoresizingMaskIntoConstraints(false)

        indicatorBackView .addSubview(indicator)
        
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[indicator]-30-|", options: .allZeros, metrics: nil, views: ["indicator":indicator])
        indicatorBackView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-30-[indicator]-30-|", options: .allZeros, metrics: nil, views: ["indicator":indicator])
        indicatorBackView.addConstraints(constraints)
        
        
        
        indicator.startAnimating()
        
        indicatorBackView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(indicatorBackView)
        var constraint = NSLayoutConstraint(item: indicatorBackView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBackView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        
        self.addConstraint(constraint)

        
    }
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        if let superview = superview {
            // remove old super view
            var list = IPaActivityIndicator.workingIndicators[superview]
            if list != nil {
                var list = list!
                if let index = find(list, self) {
                    list.removeAtIndex(index)
                    IPaActivityIndicator.workingIndicators[superview] = list
                    
                }
            }
        }
       
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // add to new super view
        if let superview = self.superview {
            var list = IPaActivityIndicator.workingIndicators[superview]
            if list == nil {
                list = [IPaActivityIndicator]()
            }
            var mlist = list!
            mlist.append(self)
            IPaActivityIndicator.workingIndicators[superview] = mlist
        }
    }
// MARK:static public function
    static func show(inView:UIView) -> IPaActivityIndicator {
        let indicator = IPaActivityIndicator(view:inView)
        inView.addSubview(indicator)
        return indicator
    }
    static func hide(fromView:UIView) {
        if let list = IPaActivityIndicator.workingIndicators[fromView] {
            if let indicator = list.last {
                indicator.removeFromSuperview()
            }
        }
    }
    static func hideAll(fromView:UIView) {
        if let list = IPaActivityIndicator.workingIndicators[fromView] {
            for indicator in list {
                indicator.removeFromSuperview()
            }
           
        }
    }
}