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
    static var workingIndicators = [UIView:IPaActivityIndicator]()
    lazy var indicator = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
    lazy var indicatorBackView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    convenience init(view:UIView) {
        self.init(frame: view.bounds)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }

    func initialSetting() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.clear
        indicatorBackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        indicatorBackView.layer.cornerRadius = 10
        indicatorBackView.clipsToBounds = true
        indicator.translatesAutoresizingMaskIntoConstraints = false

        indicatorBackView .addSubview(indicator)
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[indicator]-30-|", options: [], metrics: nil, views: ["indicator":indicator])
        indicatorBackView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[indicator]-30-|", options: [], metrics: nil, views: ["indicator":indicator])
        indicatorBackView.addConstraints(constraints)
        
        
        
        indicator.startAnimating()
        
        indicatorBackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorBackView)
        var constraint = NSLayoutConstraint(item: indicatorBackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraint(constraint)

        
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let superview = superview {
            // remove old super view
            let currentIndicator = IPaActivityIndicator.workingIndicators[superview]
            if currentIndicator != nil && currentIndicator != self{
                //should not be here
                currentIndicator!.removeFromSuperview()
            }

        }
       
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // add to new super view
        if let superview = self.superview {
            IPaActivityIndicator.workingIndicators[superview] = self
        }
    }
// MARK:static public function
    static func show(_ inView:UIView) {
        let indicator = IPaActivityIndicator(view:inView)
        DispatchQueue.main.async(execute: {
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            inView.addSubview(indicator)

            
            let viewsDict:[String:UIView] = ["view": indicator]
            inView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",options:[.alignAllTop,.alignAllBottom],metrics:nil,views:viewsDict))
            inView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",options:[.alignAllLeading,.alignAllTrailing],metrics:nil,views:viewsDict))
            
            
        })
        
    }
    static func hide(_ fromView:UIView) {
        DispatchQueue.main.async(execute: {
            if let indicator = IPaActivityIndicator.workingIndicators[fromView] {
                indicator.removeFromSuperview()
                IPaActivityIndicator.workingIndicators.removeValue(forKey: fromView)
            }
        })

    }
}
