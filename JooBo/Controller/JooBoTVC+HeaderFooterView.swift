//
//  JooBoTVC+ViewObject+Layout.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 7..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase

extension JooBoTVC {
    
    //헤더뷰 푸터뷰 위치
    func setHeaderViewAndFooterViewLayout(){
        //헤더뷰 위치 및 헤더뷰 안에 라벨
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height:100)
        tableView.tableHeaderView = headerView
        headerView.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor,constant: -18).isActive = true
        
        //푸터뷰 위치및 푸터뷰 안 텍스트 뷰
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height:350)
        tableView.tableFooterView = footerView
        
        footerView.addSubview(commentSeperatorView)
        footerView.addSubview(commentLabel)
        footerView.addSubview(prayLabel)
        footerView.addSubview(commentTextView)
        footerView.addSubview(prayTextView)
        
        //구분선
        commentSeperatorView.topAnchor.constraint(equalTo: footerView.topAnchor,constant:20).isActive = true
        commentSeperatorView.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant:10).isActive = true
        commentSeperatorView.rightAnchor.constraint(equalTo: footerView.rightAnchor,constant:-10).isActive = true
        commentSeperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        
        //광고라벨
        commentLabel.topAnchor.constraint(equalTo: commentSeperatorView.bottomAnchor,constant:20).isActive = true
        commentLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant:10).isActive = true
        commentLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //광고텍스트뷰
        commentTextView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor,constant:10).isActive = true
        commentTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        commentTextView.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant:10).isActive = true
        commentTextView.rightAnchor.constraint(equalTo: footerView.rightAnchor,constant:-10).isActive = true
        
        //기도라벨
        prayLabel.topAnchor.constraint(equalTo: commentTextView.bottomAnchor,constant:20).isActive = true
        prayLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant:10).isActive = true
        prayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        //기도텍스트뷰
        prayTextView.topAnchor.constraint(equalTo: prayLabel.bottomAnchor,constant:10).isActive = true
        prayTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        prayTextView.leftAnchor.constraint(equalTo: footerView.leftAnchor,constant:10).isActive = true
        prayTextView.rightAnchor.constraint(equalTo: footerView.rightAnchor,constant:-10).isActive = true
        prayTextView.bottomAnchor.constraint(equalTo: footerView.bottomAnchor,constant:-10).isActive = true
        
    }
}
