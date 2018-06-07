//
//  JooBoTVC+table.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 7..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase

extension JooBoTVC {
    //1.섹션지정
    override func numberOfSections(in tableView: UITableView) -> Int {
        if JooboOneModelList.count > 0 {
            
            return 1
        }
        //행이 하나도 없을때
        let rect = CGRect(x: 0,
                          y: 0,
                          width: self.tableView.bounds.size.width,
                          height: self.tableView.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        noDataLabel.text = "주보관리자가 주보를 작성중입니다.\n\n조금만 기다려주세요 :)"
        noDataLabel.numberOfLines = 3
        noDataLabel.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16.5)
        noDataLabel.textColor = UIColor.lightGray
        noDataLabel.textAlignment = NSTextAlignment.center
        self.tableView.backgroundView = noDataLabel
        self.tableView.separatorStyle = .none
        
        return 0
        
    }
    
    //2.테이블 행 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JooboOneModelList.count
    }
    
    //3.테이블 구성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? JooBoCell
        cell?.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        
        if let title = JooboOneModelList[indexPath.row].title, let content = JooboOneModelList[indexPath.row].content, let people = JooboOneModelList[indexPath.row].people {
            cell?.titleLabel.text = title
            if content == "" {
                cell?.contentLabel.text = content
            }else{
                cell?.contentLabel.text = "<\(content)>"
                
            }
            cell?.peopleLabel.text = people
        }
        return cell!
    }
    
    //4.테이블 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
}
