//
//  JooBoCell.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 6..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class JooBoCell: UITableViewCell {

    //제목
     let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    
    //중간구분선 or 내용
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    
    //인도자
    let peopleLabel: UILabel = {
        let label = UILabel()
        label.text = "인도자"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //선택됐을 때 no hover
        selectionStyle = .none
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(peopleLabel)
        setLayout()
    }
    
    //제약조건
    func setLayout(){
        
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        contentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        peopleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        peopleLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -20).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
