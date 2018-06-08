//
//  JooBoTVC.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 6..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class JooBoTVC: UITableViewController {
    
    //주보 한 행에 들어 있는데이터 객체 담을 배열
    var JooboOneModelList = [JooboOneModel]()
    var jooboTVC : JooBoTVC?
    var churchName : String?
    let cellId = "cellId"
    var loadingPageCheck = true
    
    
    //헤더
    let headerView : UIView = {
        let header = UIView()
        header.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        return header
    }()
    
    //헤더뷰 안 날짜
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "0000.00.00"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    //헤더뷰 예배순서
    let worshipLabel: UILabel = {
        let label = UILabel()
        label.text = "예배순서"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    //광고 구분선 만들기
    let commentSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //광고, 중보기도 footerView
    let footerView : UIView = {
        let footer = UIView()
        footer.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        return footer
    }()
    
    //광고 라벨
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "📣광고사항"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    
    //기도 라벨
    let prayLabel: UILabel = {
        let label = UILabel()
        label.text = "🙏중보기도"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    //광고
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14)
        //textView.textAlignment = .center
        textView.isEditable = false
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 5
        textView.clipsToBounds = true
        //textView.isScrollEnabled = false
        return textView
    }()
    
    //기도
    let prayTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        textView.text = ""
        textView.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.layer.borderWidth = 0.3
        textView.layer.cornerRadius = 5
        textView.clipsToBounds = true
        //textView.isScrollEnabled = false
        return textView
    }()
    
    
    //로딩뷰
    let loadingView : UIView = {
        let loadingView = UIView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        loadingView.layer.cornerRadius = 20
        loadingView.layer.borderWidth = 0.5
        loadingView.layer.borderColor = UIColor.lightGray.cgColor
        loadingView.layer.masksToBounds = true;
        return loadingView
    }()
    
    //로딩 라벨
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .center
        label.textColor = UIColor.black
        let stringValue = "하나님은 영이시니 예배하는 자가\n신령과 진정으로 예배할찌니라\n\n\n요한복음 4:24"
        let attrString = NSMutableAttributedString(string: stringValue)
        var style = NSMutableParagraphStyle()
        style.lineSpacing = 11
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0, length: stringValue.characters.count))
        label.attributedText = attrString
        label.textAlignment = .center
        return label
    }()
    
    
    //뷰가 로딩되기 시작할때 먼저 로딩뷰 띄우기
    override func viewWillAppear(_ animated: Bool) {
        
        if(loadingPageCheck){
            showLoadingScreen()
        }else{
            
        }
        
    }
    
    //진입점
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //테이블 정보등록 및 스크롤라인 제거
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        tableView.separatorStyle = .none
        tableView.register(JooBoCell.self, forCellReuseIdentifier: cellId)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        //메인화면이동
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.mainActoin))
        
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        //헤더뷰 풋터뷰
        self.setHeaderViewAndFooterViewLayout()
        
        //로그인 로그아웃 체크
        self.checkIfUserIsLoggedIn()
        
    }
    
    //메인화면 전환
   @objc func mainActoin(){
        let mainView = MainVC()
        //메인상세 화면을 rootView로 만들어 주기
        let navController = UINavigationController(rootViewController: mainView)
        self.present(navController, animated: true, completion: nil)
    }
    
}
