//
//  ViewController.swift
//  IPaIndicator
//
//  Created by ipapamagic@gmail.com on 06/25/2017.
//  Copyright (c) 2017 ipapamagic@gmail.com. All rights reserved.
//

import UIKit
import IPaIndicator

class ViewController: UIViewController {

    @IBOutlet var ipaProgressView:IPaRoundProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showLoadingText(_ sender: Any) {
        IPaActivityIndicator.show(self.view,text:"loading...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 , execute: {
            IPaActivityIndicator.hide(self.view)
        })
    }
    @IBAction func onPlayProgress(_ sender: Any) {
        let indicator = IPaProgressIndicator.show(self.view)
        
        ipaProgressView.progress = 0
        indicator.progress = 0
        indicator.setNeedsDisplay()
        var counter = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            timer in
            counter += 1
            if counter > 10 {
                return
            }
            UIView.animate(withDuration: 0.3, animations: {
                indicator.progress = CGFloat(counter) / 10.0
                
            },completion: {
                finished in
                if counter == 10 {
                    timer.invalidate()
                    indicator.removeFromSuperview()
                }
            })
            
            
            
        })
        
        
//        
//        UIView.animate(withDuration: 3, animations: {
//            self.ipaProgressView.progress = 0.5
//            indicator.progress = 1
//            
//        },completion: {
//            finished in
//            UIView.animate(withDuration: 3, animations: {
//                self.ipaProgressView.progress = 0
//                indicator.progress = 0
//                
//            },completion: {
//                finished in
//                indicator.removeFromSuperview()
//            })
//
//        })
        
    }
    @IBAction func onShow(_ sender: Any) {
        _ = IPaActivityIndicator.show(self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 , execute: {
            IPaActivityIndicator.hide(self.view)
        })
    }
}

