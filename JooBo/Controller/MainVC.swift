//
//  MainVC.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 8..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class MainVC: UIViewController {


    //헤더 라벨
    let headLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.black
        let stringValue = "안녕하세요. 반갑습니다."
        let attrString = NSMutableAttributedString(string: stringValue)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 11
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    
    
    
    //첫번째 라벨
    lazy var oneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.black
        let tap = UITapGestureRecognizer(target: self, action: #selector(chruchIntro))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        let stringValue = "✧교회소개"
        let attrString = NSMutableAttributedString(string: stringValue)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 11
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    

    
    //두번째 라벨
    lazy var twoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.black
        let stringValue = "✧예배시간안내"
        let attrString = NSMutableAttributedString(string: stringValue)
        let tap = UITapGestureRecognizer(target: self, action: #selector(worshipTime))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 11
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    
    //세번째 라벨
    let threeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.black
        let stringValue = "✧지난주설교"
        let attrString = NSMutableAttributedString(string: stringValue)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 11
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    
    //네번째 라벨
    let fourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.black
        let stringValue = "✧마이페이지"
        let attrString = NSMutableAttributedString(string: stringValue)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 11
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    

    
    
    //진입점
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action:  #selector(cancelAction))
        self.navigationItem.title = "주보사랑"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "성경본문", style: .plain, target: self, action:  #selector(showBible))
        
        //메인화면이동
        //self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "나가기", style: .plain, target: self, action: #selector(handleLogout))
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        setLayout()
    }

    //바이블 열기
    @objc func showBible(){
        let showBibleVC = ShowBibleVC()
        //메인상세 화면을 rootView로 만들어 주기
        let navController = UINavigationController(rootViewController: showBibleVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    //취소 함수
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //레이아웃 조정
    func setLayout(){
        view.addSubview(headLabel)

        view.addSubview(oneLabel)
        view.addSubview(twoLabel)
        view.addSubview(threeLabel)
        view.addSubview(fourLabel)


        
        //헤더
        headLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:80).isActive = true
        headLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        headLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        //--------------------------//
        

        oneLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor,constant:80).isActive = true
        oneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        oneLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        oneLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        twoLabel.topAnchor.constraint(equalTo: oneLabel.bottomAnchor,constant:15).isActive = true
        twoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twoLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        twoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        threeLabel.topAnchor.constraint(equalTo: twoLabel.bottomAnchor,constant:15).isActive = true
        threeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        threeLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        threeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        fourLabel.topAnchor.constraint(equalTo: threeLabel.bottomAnchor,constant:15).isActive = true
        fourLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fourLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        fourLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    
    //교회 소개뷰
    let churchIntroView : UIView = {
        let churchIntroView = UIView()
        churchIntroView.translatesAutoresizingMaskIntoConstraints = false
        churchIntroView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        churchIntroView.layer.cornerRadius = 20
        churchIntroView.layer.borderWidth = 0.5
        churchIntroView.layer.borderColor = UIColor.green.cgColor
        churchIntroView.layer.masksToBounds = true;
        return churchIntroView
    }()
    
    //프로필 이미지
    let churchIntroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login2.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //교회소개
    @objc func chruchIntro(){
        print("교회 소개")
//        churchIntroView.bounds.size.width = view.bounds.size.width - 20
//        churchIntroView.bounds.size.height = view.bounds.size.height - 130
//        churchIntroView.center = view.center
//        view.addSubview(churchIntroView)
        
        
        view.addSubview(churchIntroView)
        churchIntroView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        churchIntroView.topAnchor.constraint(equalTo: view.topAnchor, constant:80).isActive = true
        churchIntroView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-30).isActive = true
        churchIntroView.widthAnchor.constraint(equalToConstant: view.bounds.width - 40).isActive = true
        
        churchIntroView.alpha = 1
        
        churchIntroView.addSubview(churchIntroImageView)
        churchIntroImageView.leftAnchor.constraint(equalTo: churchIntroView.leftAnchor).isActive = true
        churchIntroImageView.rightAnchor.constraint(equalTo: churchIntroView.rightAnchor).isActive = true
        churchIntroImageView.centerYAnchor.constraint(equalTo: churchIntroView.centerYAnchor).isActive = true

        
        //로딩뷰 애니메이션 나타나기
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
            self.churchIntroView.alpha = 1
        }) { (success) in
            //self.hideLoadingScreen()
        }
    }
    
    @objc func worshipTime(){
        print("예배시간 안내")
    }
    

}

