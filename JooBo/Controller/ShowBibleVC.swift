//
//  ShowBibleVC.swift
//  JooBo
//
//  Created by MacBookPro on 2018. 6. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class ShowBibleVC: UIViewController {
    
    //
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "성경본문을 가져오고 있습니다:)"
        textView.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 15)
        //textView.textAlignment = .center
        textView.isEditable = false
        textView.layer.borderWidth = 0
        textView.layer.borderColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0).cgColor

        return textView
    }()
    
    //취소 함수
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action:  #selector(cancelAction))
        view.backgroundColor = UIColor(red:0.92, green:0.92, blue:0.92, alpha:1.0)
        onPostShowBible()
        
        //onHttpRequest()
        
        view.addSubview(commentTextView)
        
        commentTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 5).isActive = true
        commentTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -5).isActive = true
        commentTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //commentTextView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        commentTextView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    
    func onPostShowBible(){
        var bibletext = ""
        var jang = ""
        var title = ""
        print("포스트 방식 데이터 가지러옴")
        // 1. 전송할 값 준비
        //2. JSON 객체로 변환할 딕셔너리 준비
        //let parameter = ["create_name" : "kkkkkkkk", "create_age" : "909090"]
        //let postString = "create_name=13&create_age=Jack"
        // 3. URL 객체 정의
        guard let url = URL(string: "https://polar-reef-71177.herokuapp.com/bible_search_json") else {return}
        
        // 3. URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 4. HTTP 메시지에 포함될 헤더 설정
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = "maintext=히브리서&jang=11&jeol=1&jeol2=10".data(using:String.Encoding.utf8, allowLossyConversion: false)
        request.httpBody = body
        
        
        // 5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let res = response{
                print(res)
            }
            
            if let data = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)

                   
                    guard let newValue = json as? Array<Any> else {
                        print("invalid format")
                        return
                    }
                    
                    for item in newValue{
                        
                        if let data = item as? [String:Any]{
                            
                            if let book = data["book"] , let chapter = data["chapter"] ,let verse = data["verse"] ,let content = data["content"]{
                                
                        
//                                 bibletext += String(describing: book) + String(describing: chapter) + String(describing: verse) + String(describing: content) + "\n"
                                
                                jang = String(describing: chapter)
                                title = String(describing: book)
                                
                                bibletext += String(describing: verse) + "." + String(describing: content) + "\n\n"
                            }
    
                        }
                    }
                    DispatchQueue.main.async {
                        //라인 간격 줄간격
                        let style = NSMutableParagraphStyle()
                        style.lineSpacing = 7
                        let attributes = [NSAttributedStringKey.paragraphStyle : style,NSAttributedStringKey.font:UIFont(name: "NanumMyeongjo-YetHangul", size: 16)]
                        self.commentTextView.attributedText = NSAttributedString(string: bibletext, attributes: attributes)
                        
                        let title_ko = self.searchBibleName(index: Int(title)!)
                        
                        self.navigationItem.title = "\(title_ko) \(jang)장"
                    }
                    
                    // Check for the weather parameter as an array of dictionaries and than excess the first array's description
//                    if let verse = newValue["verse"], let chapter = newValue["chapter"],let book = newValue["book"],let content = newValue["content"] {
//                        print(verse)
//                        print(chapter)
//                        print(book)
//                        print(content)
//                    }
                    
                    
//                    let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    if let items = jsonResult["items"] as! NSArray { for item in items { print(item["published"]) print(item["title"]) print(item["content"]) } }
                    
                    
                    //Convert to Data
                   // let jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                    
                    //Convert back to string. Usually only do this for debugging
                    //if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    //    print(JSONString)
                    //}
                    
                    
                }catch{
                    print(error)
                }
            }
            // 6. POST 전송
            }.resume()
        
    }
    

    
    func searchBibleName(index: Int) -> String {
        let searchIndex = index - 1
        
        let book = [ "창세기",
                    "출애굽기",
                    "레위기",
                    "민수기",
                    "신명기",
                    "여호수아",
                    "사사기",
                    "룻기",
                    "사무엘상",
                    "사무엘하",
                    "열왕기상",
                    "열왕기하",
                    "역대상",
                    "역대하",
                    "에스라",
                    "느헤미야",
                    "에스더",
                    "욥기",
                    "시편",
                    "잠언",
                    "전도서",
                    "아가서",
                    "이사야",
                    "예레미야",
                    "예레미야애가",
                    "에스겔",
                    "다니엘",
                    "호세아",
                    "요엘",
                    "아모스",
                    "오바댜",
                    "요나",
                    "미가",
                    "나훔",
                    "하박국",
                    "스바냐",
                    "학개",
                    "스가랴",
                    "말라기",
                    "마태복음",
                    "마가복음",
                    "누가복음",
                    "요한복음",
                    "사도행전",
                    "로마서",
                    "고린도전서",
                    "고린도후서",
                    "갈라디아서",
                    "에베소서",
                    "빌립보서",
                    "골로새서",
                    "데살로니가전서",
                    "데살로니가후서",
                    "디모데전서",
                    "디모데후서",
                    "디도서",
                    "빌레몬서",
                    "히브리서",
                    "야고보서",
                    "베드로전서",
                    "베드로후서",
                    "요한일서",
                    "요한이서",
                    "요한삼서",
                    "유다서",
                    "요한계시록"]
        
        return book[searchIndex]
    }

   
    
    func onHttpRequest() {
        
        
        //URL생성
        guard let url = URL(string: "https://polar-reef-71177.herokuapp.com/bible_search_json") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "get" //get : Get 방식, post : Post 방식
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            //error 일경우 종료
            guard error == nil && data != nil else {
                if let err = error {
                    print(err.localizedDescription)
                }
                return
            }
            
            //data 가져오기
            if let _data = data {
                if let strData = NSString(data: _data, encoding: String.Encoding.utf8.rawValue) {
                    let str = String(strData)
                    print(str)
                    //메인쓰레드에서 출력하기 위해
                    DispatchQueue.main.async {
                        print(str)
                    }
                }
            }else{
                print("data nil")
            }
        })
        task.resume()
        
    }
    
    func onPostShowBible2(){
        
        print("포스트 방식 데이터 가지러옴")
        // 1. 전송할 값 준비
        //2. JSON 객체로 변환할 딕셔너리 준비
        let parameter = ["create_name" : "kkkkkkkk", "create_age" : "909090"]
        //let postString = "create_name=13&create_age=Jack"
        // 3. URL 객체 정의
        guard let url = URL(string: "https://polar-reef-71177.herokuapp.com/bible_search_json") else {return}
        // 3. URLRequest 객체 정의 및 요청 내용 담기
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // 4. HTTP 메시지에 포함될 헤더 설정
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = "create_name=mylove&create_age=1212".data(using:String.Encoding.ascii, allowLossyConversion: false)
        request.httpBody = body
        
        // 5. URLSession 객체를 통해 전송 및 응답값 처리 로직 작성
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let res = response{
                print(res)
            }
            
            if let data = data {
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch{
                    print(error)
                }
            }
            // 6. POST 전송
            }.resume()
        
    }
    
}

