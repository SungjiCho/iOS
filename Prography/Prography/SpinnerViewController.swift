//
//  SpinnerViewController.swift
//  Prography
//
//  Created by 조성지 on 2020/03/04.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit

var aView: UIView?

extension UIViewController {

    func showSpinner(){
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = .black
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)

        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false){ (t) in
            self.removeSpinner()
        }
    }

    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }

}
