//
//  ViewController.swift
//  DrawAndGuess-iOS
//
//  Created by 闫润邦 on 2022/7/13.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginBtn = UIButton(type: .system)
    let regBtn = UIButton(type: .system)
    let nameTextField = UITextField()
    let pswTextField = UITextField()
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let inputStackView = UIStackView()
    let iconStackView = UIStackView()
    let tapRec = UITapGestureRecognizer()
    var usr = User()
    var ppsw = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //关闭APP时不能正常logout
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIScene.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIScene.didDisconnectNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIScene.willEnterForegroundNotification, object: nil)
        
        view.backgroundColor = .white
        view.addSubview(loginBtn)
        view.addSubview(regBtn)
        view.addSubview(inputStackView)
        view.addSubview(iconStackView)
        
        configureLoginBtn()
        configureRegBtn()
        configureNameTextField()
        configurePswTextField()
        configureInputStackView()
        configureTitleLabel()
        configureIconView()
        configureIconStackView()
        configureGestureRecgonizer()
        configureConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Disappear")
    }



}


//Configuration Functions
extension LoginViewController {
    func configureLoginBtn() {
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.layer.cornerRadius = view.bounds.width / 39
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureRegBtn() {
        regBtn.setTitle("注册", for: .normal)
        regBtn.backgroundColor = .lightGray
        regBtn.setTitleColor(.white, for: .normal)
        regBtn.layer.cornerRadius = loginBtn.layer.cornerRadius
        regBtn.addTarget(self, action: #selector(reg), for: .touchUpInside)
        regBtn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureNameTextField() {
        nameTextField.placeholder = "用户名"
        nameTextField.delegate = self
        nameTextField.returnKeyType = .next
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.layer.borderWidth = 0
        nameTextField.layer.cornerRadius = 10
        
        let color = UIColor.lightGray.cgColor
        
        nameTextField.backgroundColor = UIColor(cgColor: color.copy(alpha: 0.12)!)
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.leftView = UIView(frame: CGRect(x: 0,
                                                      y: 0,
                                                      width: 20,
                                                      height: 40))
        nameTextField.leftViewMode = .always
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configurePswTextField() {
        pswTextField.placeholder = "密码"
        pswTextField.isSecureTextEntry = true
        pswTextField.returnKeyType = .go
        pswTextField.clearButtonMode = .always
        pswTextField.delegate = self
        pswTextField.layer.borderWidth = nameTextField.layer.borderWidth
        pswTextField.layer.cornerRadius = nameTextField.layer.cornerRadius
        pswTextField.layer.borderColor = nameTextField.layer.borderColor
        pswTextField.backgroundColor = nameTextField.backgroundColor
        pswTextField.leftView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: 20,
                                                     height: 40))
        pswTextField.leftViewMode = nameTextField.leftViewMode
        pswTextField.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureTitleLabel() {
        titleLabel.text = "你画我猜"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.font = titleLabel.font.withSize(view.bounds.width / 15)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureInputStackView() {
        let view1 = UIView()
        let view2 = UIView()
        inputStackView.addArrangedSubview(view1)
        inputStackView.addArrangedSubview(nameTextField)
        inputStackView.addArrangedSubview(pswTextField)
        inputStackView.addArrangedSubview(view2)
        inputStackView.alignment = .center
        inputStackView.distribution = .equalCentering
        inputStackView.axis = .vertical
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureIconView() {
        iconView.contentMode = .scaleAspectFill
        iconView.image = UIImage(systemName: "paintpalette")
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureIconStackView() {
        iconStackView.axis = .horizontal
        iconStackView.alignment = .bottom
        iconStackView.distribution = .equalCentering
        iconStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let view1 = UIView()
        iconStackView.addArrangedSubview(view1)
        iconStackView.addArrangedSubview(iconView)
        iconStackView.addArrangedSubview(titleLabel)
        
    }
    
    func configureGestureRecgonizer() {
        tapRec.numberOfTapsRequired = 1
        tapRec.numberOfTouchesRequired = 1
        tapRec.addTarget(self, action: #selector(fireGesture(_:)))
        view.addGestureRecognizer(tapRec)
        view.isUserInteractionEnabled = true
    }
    
    func configureConstraints() {
        let constraints = [
            inputStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.height / 4.5),
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputStackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 4),
            
            loginBtn.topAnchor.constraint(equalTo: inputStackView.bottomAnchor),
            loginBtn.heightAnchor.constraint(equalToConstant: 50),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            regBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
            regBtn.heightAnchor.constraint(equalTo: loginBtn.heightAnchor),
            regBtn.leadingAnchor.constraint(equalTo: loginBtn.leadingAnchor),
            regBtn.trailingAnchor.constraint(equalTo: loginBtn.trailingAnchor),
            
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            pswTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            pswTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            pswTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            iconStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            iconStackView.bottomAnchor.constraint(equalTo: inputStackView.topAnchor),
            iconStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            iconStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            iconView.heightAnchor.constraint(equalTo: iconStackView.heightAnchor),
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),

            titleLabel.heightAnchor.constraint(equalToConstant: view.bounds.height / 10),
            titleLabel.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.5)
        ]
        view.addConstraints(constraints)
    }
}

extension LoginViewController {
    @objc func login() {
        
        guard let name = nameTextField.text, name != "" else {
            presentOkAlert(title: "用户名为空", msg: "请输入用户名")
            return
        }
        
        guard let psw = pswTextField.text, psw != "" else {
            presentOkAlert(title: "密码为空", msg: "请输入密码")
            return
        }
        
        guard let percentName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            presentOkAlert(title: "用户名不合法", msg: "请输入合法的用户名")
            return
        }
        let urlStr = urlPrefix + "/users/login" + "/" + percentName + "/" + psw
        guard let url = URL(string: urlStr) else {
            presentOkAlert(title: "系统错误", msg: "请稍后重试")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Connection": "close",
        ]
        
        //Login Task
        let task = URLSession.shared.dataTask(with: request) { dat, resp, err in
            if err != nil {
                self.presentOkAlert(title: "服务器错误", msg: err!.localizedDescription)
                return
            }

            guard let data = dat, let response = resp as? HTTPURLResponse else {
                self.presentOkAlert(title: "内部错误", msg: "")
                return
            }
            
            guard response.statusCode == 200 else {
                guard let str = String(data: data, encoding: .utf8) else {
                    self.presentOkAlert(title: "内部错误", msg: "")
                    return
                }
                self.presentOkAlert(title: "登录失败", msg: str)
                return
            }
            
            guard let u = try? JSONDecoder().decode(User.self, from: data) else {
                self.presentOkAlert(title: "内部错误", msg: "")
                return
            }
            self.usr = u
            DispatchQueue.main.async {
                self.ppsw = psw
                let alert = UIAlertController(title: "登录成功", message: "恭喜，登录成功！🎉", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    let drawVC = DrawViewController()
                    self.navigationController?.pushViewController(drawVC, animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
            
            
        }
        task.resume()
    }
    
    @objc func reg() {
        print("register")
        let regVC = RegisterViewController()
        regVC.father = self
        navigationController?.pushViewController(regVC, animated: true)
    }
    
    @objc func fireGesture(_ gestureRecgonizer: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        pswTextField.resignFirstResponder()
    }
    
    @objc func didEnterBackground() {
        print("Did Enter Background")
        if usr.userName == "" {
            return
        }
        let urlStr = urlPrefix + "/users/logout" + "/" + usr.userName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! + "/" + usr.userId
        guard let url = URL(string: urlStr) else {
            return
        }
        print(urlStr)
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = [
            "Connection": "close",
        ]
        let task = URLSession.shared.dataTask(with: request) { dat, resp, err in
            print("sent")
        }
        task.resume()
    }
    
    @objc func willEnterForeground() {
        print("Will Enter Foreground")
        if usr.userName == "" {
            return
        }
        let urlStr = urlPrefix + "/users/login" + "/" + usr.userName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)! + "/" + ppsw
        guard let url = URL(string: urlStr) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Connection": "close",
        ]
        let task = URLSession.shared.dataTask(with: request) { dat, resp, err in
            if err != nil {
                self.presentOkAlert(title: "服务器错误", msg: err!.localizedDescription)
                return
            }

            guard let data = dat, let response = resp as? HTTPURLResponse else {
                self.presentOkAlert(title: "内部错误", msg: "")
                return
            }
            
            guard response.statusCode == 200 else {
                guard let str = String(data: data, encoding: .utf8) else {
                    self.presentOkAlert(title: "内部错误", msg: "")
                    return
                }
                self.presentOkAlert(title: "登录失败", msg: str)
                return
            }
            
            guard let u = try? JSONDecoder().decode(User.self, from: data) else {
                self.presentOkAlert(title: "内部错误", msg: "")
                return
            }
            self.usr = u
//            self.presentOkAlert(title: "登录成功", msg: self.usr.userName)
            print("resume successfully")
        }
        task.resume()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            pswTextField.becomeFirstResponder()
        } else {
            pswTextField.resignFirstResponder()
            login()
        }
        return true
    }
    
}

extension UIViewController {
    func presentOkAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
        
    }
}
