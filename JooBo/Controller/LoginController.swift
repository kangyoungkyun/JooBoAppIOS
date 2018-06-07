
import UIKit
import Firebase
class LoginController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    //-1
    var jooboTVC: JooBoTVC?
    
    //피커뷰 데이터
    var churchArray:[String] = []
    
    
    //church 피커뷰 객체
    let churchPickerView :UIPickerView = {
        let pick = UIPickerView()
        return pick
    }()
    
    //피커뷰 상속 메서드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //피커뷰 row 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let countrows : Int = churchArray.count
        return countrows
    }
    
    //피커뷰 제목
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleRow = churchArray[row]
        return titleRow
        
    }
    
    //피커뷰를 선택했을 때
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let titleRow = churchArray[row]
        nameTextField.text = titleRow
        nameTextField.resignFirstResponder()
    }
    
    
    //컨테이너 뷰
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    //로그인 버튼
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.77, green:0.77, blue:0.77, alpha:1.0)
        button.setTitle("등록", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    
    
    @objc func handleLoginRegister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else{
            handleRegister()
        }
    }
    
    
    //로그인 버튼 액션
    func handleLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("값이 없거나 잘못된 형식")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            //-2
            self.jooboTVC?.setupNavBarTitle()
            //로그인 성공시 로그인창 내려주기
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    //등록 버튼 액션
    func handleRegister(){
        //유효성 검사
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("값이 없거나 잘못된 형식")
            return
        }
        //파이어베이스 가입
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            //에러 발생
            if let error = error{
                print(error)
                return
            }
            //가입후 uid  넘겨준다. uid 가 nil이면 return
            guard let uid = user?.uid else {
                return
            }
            //유저가 저장될 firebase 위치
            let ref = Database.database().reference()
            let uesrReference = ref.child("users").child(uid)
            //딕셔너리 타입으로 값을 넣어준다.
            let values = ["name":name,"email":email, "lev":"1"]
            uesrReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err {
                    print(err)
                    return
                }
                self.jooboTVC?.setupNavBarTitle()
                //가입 성공시 로그인창 내려주기
                self.dismiss(animated: true, completion: nil)
                print("가입 성공")
            })
            
        }
        
    }
    
    
    //이름 텍스트 필드
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "교회선택"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    //이름 구분선
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //이메일 텍스트 필드
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이메일"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    //이메일 구분선
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //패스워드 텍스트 필드
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    //프로필 이미지
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login2.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var loginRegisterSegmentedControl:UISegmentedControl = {
        let sc = UISegmentedControl(items: ["로그인","등록"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        sc.tintColor = UIColor(red:0.77, green:0.77, blue:0.77, alpha:1.0)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    //등록 세그먼트
    @objc func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControlState())
        
        let containerHeight =  loginRegisterSegmentedControl.selectedSegmentIndex  == 0 ? 100 : 150
        inputsContainerViewHeightAnchor?.constant = CGFloat(containerHeight)
        
        //이름 필드 높이
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = loginRegisterSegmentedControl.selectedSegmentIndex  == 0 ? nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0) : nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //이메일 필드 높이
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = loginRegisterSegmentedControl.selectedSegmentIndex  == 0 ? emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2) : emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //비밀번호 필드 높이
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = loginRegisterSegmentedControl.selectedSegmentIndex  == 0 ? passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2) : passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    
    
    //진입점
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        self.hideKeyboard()
        
        churchPickerView.delegate = self
        churchPickerView.dataSource = self
        
        //입력 객체
        setupInputsContainerView()
        //로그인버튼 객체
        setupLoginRegisterButton()
        //이미지뷰 객체
        setupProfileImageView()
        //로그인 세그먼트 컨트롤
        setupLoginRegisterSegmentedControl()
        
        
        
        
        let ref = Database.database().reference()
        ref.child("admin").observeSingleEvent(of: .value) { (snapshot) in
            
            for child in snapshot.children{
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let churchname = childValue["name"] as? String{
                    self.churchArray.append(churchname)
                }
            }
            
        }
        
        
        
    }
    
    //로그인등록 버튼 세그먼트 제약조건
    func setupLoginRegisterSegmentedControl(){
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -15).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
    }
    
    //높이 제약조건
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    
    //컨테이너 뷰 제약조건 설정
    func setupInputsContainerView(){
        //컨테이너 뷰 제약조건
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo:view.widthAnchor,constant:-24).isActive = true
        
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        
        //컨테이너 뷰 안에 뷰객체 넣기
        inputsContainerView.addSubview(nameTextField)
        nameTextField.inputView = churchPickerView
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        //뷰객체 제약조건 설정
        //이름
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        
        //이름 구분선
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        //이메일
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 0).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        
        //이메일 구분선
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        //비밀번호
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 0).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
    }
    
    //로그인버튼 제약 조건 설정
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //로그인버튼 제약 조건 설정
    func setupProfileImageView(){
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -35).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    
    
    
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
