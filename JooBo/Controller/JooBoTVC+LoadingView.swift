//
//  JooBoTVC+LoadingView.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 7..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase

extension JooBoTVC {

    
    //로딩뷰 레이아웃 + 애니매이션
    func showLoadingScreen(){
        view.addSubview(loadingView)
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: view.bounds.height - 40).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
        
        loadingView.alpha = 1
        
        loadingView.addSubview(loadingLabel)
        loadingLabel.leftAnchor.constraint(equalTo: loadingView.leftAnchor).isActive = true
        loadingLabel.rightAnchor.constraint(equalTo: loadingView.rightAnchor).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        //loadingLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        loadingLabel.widthAnchor.constraint(equalTo: loadingView.widthAnchor).isActive = true
        
        //로딩뷰 애니메이션 나타나기
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
            self.loadingView.alpha = 1
        }) { (success) in
            self.hideLoadingScreen()
        }
        
    }
    //로딩뷰 숨기기
    func hideLoadingScreen(){
        UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.loadingView.transform =
                CGAffineTransform(translationX: 0, y: 10)
        }) { (success) in
            UIView.animate(withDuration: 0.7, animations: {
                self.loadingView.transform = CGAffineTransform(translationX: 0, y: -800)
            })
        }
    }
    

}
