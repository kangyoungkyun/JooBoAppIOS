//
//  JooBoTVC+LoginCheck.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 7..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase

extension JooBoTVC {
    
    //로그인or로그아웃 체크 함수
    func checkIfUserIsLoggedIn(){
        //로그아웃 되었을 때 실행
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            //로그인 되었으면 네비게이션 타이틀의 제목을 유저 이름으로 지정해준다.
            setupNavBarTitle()
            
        }
    }
    
    
    //로그인 되었으면 네비게이션 타이틀의 제목을 유저 이름으로 지정해준다.
    func setupNavBarTitle(){
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        
        let ref = Database.database().reference()
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                self.churchName = dictionary["name"] as? String
                
                self.setupNavBarWithChurchName(churchName: self.churchName!)
                //주보데이터 가져오기
                self.showJoobo()
                //날짜가져오기
                self.showDate()
                //주보 광고 말씀 가져오기
                self.showJooboComment()
            }
        }, withCancel: nil)
        
    }
    
    
    //네비게이션 타이틀 바 변경해주기
    func setupNavBarWithChurchName(churchName: String){
        
        let titleView = MyUIView()
        
        titleView.frame = CGRect(x:0, y:0, width: 100, height: 50)
        
        
        let nameLable = UILabel()
        titleView.addSubview(nameLable)
        nameLable.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14)
        nameLable.text = "🔔"+churchName + " 예배순서"
        //nameLable.text = "예배순서"
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        nameLable.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        
        nameLable.centerXAnchor.constraint(equalTo: titleView.centerXAnchor,constant:-30).isActive = true
        nameLable.heightAnchor.constraint(equalTo: titleView.heightAnchor).isActive = true
        
        
        self.navigationItem.titleView = titleView
        
    }
    
    //로그아웃 액션
    @objc func handleLogout(){
        
        do{
            try Auth.auth().signOut()
        } catch let logError{
            print(logError)
        }
        //-3
        jooboTVC?.setupNavBarTitle()
        let loginController = LoginController()
        loginController.jooboTVC = self
        present(loginController, animated: true, completion: nil)
    }
    
}
