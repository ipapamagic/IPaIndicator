//
//  IPaIndicator.swift
//  Pods
//
//  Created by IPa Chen on 2017/6/24.
//
//

import UIKit

@objc public class IPaIndicator: UIView {
    lazy var indicatorBlackView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }
    func initialSetting() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.clear
        indicatorBlackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        indicatorBlackView.layer.cornerRadius = 10
        indicatorBlackView.clipsToBounds = true
       
        
        indicatorBlackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorBlackView)
        var constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: indicatorBlackView, attribute: .trailing, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        
        
    }
    static func getActualInView(_ view:UIView) -> UIView {
        var actualInView = view
        while (actualInView is UITableView) {
            if let inSuperView = actualInView.superview {
                actualInView = inSuperView
            }
            else {
                return actualInView
            }
        }
        return actualInView
    }
    public class func show(_ inView:UIView) -> Self {
        let actualInView = getActualInView(inView)
        let indicator = self.init(frame:actualInView.bounds)
        DispatchQueue.main.async(execute: {
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            actualInView.addSubview(indicator)
            
            
            let viewsDict:[String:UIView] = ["view": indicator]
            actualInView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",options:[.alignAllTop,.alignAllBottom],metrics:nil,views:viewsDict))
            actualInView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",options:[.alignAllLeading,.alignAllTrailing],metrics:nil,views:viewsDict))
            
            
        })
        return indicator
    }
    public class func hide(_ fromView:UIView) {
        let actualFromView = getActualInView(fromView)
        DispatchQueue.main.async(execute: {
            let views = actualFromView.subviews.filter({
                view in
                return view is IPaIndicator
            })
            for view in views {
                view.removeFromSuperview()
            }
            
        })
        
    }
}
