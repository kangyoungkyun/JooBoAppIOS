//
//  JooBoTVC+Data.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 7..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase

extension JooBoTVC {
    //db에서 날짜 가져오기
    func showDate(){
        
        if let myChurchName = churchName{
            
            let ref = Database.database().reference().child("admin").queryOrdered(byChild: "name").queryEqual(toValue : "\(myChurchName)")
            
            ref.observe(.value) { (snapshot) in
                for snap in snapshot.children{
                    let jooBoRef = Database.database().reference().child("joobo")
                    jooBoRef.child((snap as! DataSnapshot).key).child("zero").observeSingleEvent(of: .value, with: { (snap) in
                        
                        let childSnapshot = snap //자식 DataSnapshot 가져오기
                        
                        
                        if let childValue = childSnapshot.value as? [String:Any]{
                            let date = childValue["date"] as? String ?? "0000/00/00"
                            let newDateString = date.replacingOccurrences(of: "/", with: ".")
                            self.dateLabel.text = "✧"+newDateString
                        }
                        
                    })
                }
            }
        }
    }
    
    
    
    
    //주보데이터 가져오기
    func showJoobo(){
        self.JooboOneModelList.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
        
        if let myChurchName = churchName{
            
            
            let ref = Database.database().reference().child("admin").queryOrdered(byChild: "name").queryEqual(toValue : "\(myChurchName)")
            
            ref.observe(.value) { (snapshot) in
                for snap in snapshot.children{
                    
                    let jooBoRef = Database.database().reference().child("joobo")
                    jooBoRef.child((snap as! DataSnapshot).key).observeSingleEvent(of: .value, with: { (snap) in
                        
                        for child in snap.children{
                            
                            for jooboOne in (child as! DataSnapshot).children {
                                
                                let jooboOneData = jooboOne as! DataSnapshot
                                
                                if let jooboOneResult = jooboOneData.value as? [String:Any] {
                                    if let title = jooboOneResult["title"] as? String, let content = jooboOneResult["content"] as? String, let people = jooboOneResult["people"] as? String{
                                        let JooboOneModelToShow = JooboOneModel() //데이터를 담을 클래스
                                        
                                        //데이터 삽입
                                        JooboOneModelToShow.content = content
                                        JooboOneModelToShow.title = title
                                        JooboOneModelToShow.people = people
                                        //self.JooboOneModelList.append(JooboOneModelToShow)
                                        self.JooboOneModelList.append(JooboOneModelToShow) //
                                    }
                                }
                                
                            }
                            
                            self.tableView.reloadData()
                            
                        }
                        
                    }, withCancel: { (error) in
                        print(error.localizedDescription)
                    })
                    
                }
            }
            
        }
        
    }
    
    //주보광고말씀 가져오기
    func showJooboComment(){
        
        if let myChurchName = churchName{
            
            let ref = Database.database().reference().child("admin").queryOrdered(byChild: "name").queryEqual(toValue : "\(myChurchName)")
            
            ref.observe(.value) { (snapshot) in
                for snap in snapshot.children{
                    let jooBoRef = Database.database().reference().child("joobo")
                    jooBoRef.child((snap as! DataSnapshot).key).child("two").observeSingleEvent(of: .value, with: { (snap) in
                        
                        let childSnapshot = snap //자식 DataSnapshot 가져오기
                        
                        
                        if let childValue = childSnapshot.value as? [String:Any]{
                            let comment = childValue["comment"] as? String ?? ""
                            let pray = childValue["pray"] as? String ?? ""
                            
                            
                            let style = NSMutableParagraphStyle()
                            style.lineSpacing = 11
                            let attributes = [NSAttributedStringKey.paragraphStyle : style,NSAttributedStringKey.font:UIFont(name: "NanumMyeongjo-YetHangul", size: 13)]
                            self.commentTextView.attributedText = NSAttributedString(string: comment, attributes: attributes)
                            
                            self.prayTextView.attributedText = NSAttributedString(string: pray, attributes: attributes)
                            
                            //self.commentTextView.text = comment
                            //self.prayTextView.text = pray
                        }
                        
                    })
                }
            }
        }
    }
    
    
}
