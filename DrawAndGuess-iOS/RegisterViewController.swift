//
//  RegisterViewController.swift
//  DrawAndGuess-iOS
//
//  Created by 闫润邦 on 2022/7/14.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let nameTextField = UITextField()
    let pswTextField = UITextField()
    let confirmTextField = UITextField()
    let inputStackView = UIStackView()
    let tapRec = UITapGestureRecognizer()
    let regBtn = UIButton(type: .system)
    var father: LoginViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        title = "注册"
        
        view.addSubview(inputStackView)
        view.addSubview(regBtn)
        
        configureTextFields()
        configureInputStackView()
        configureRegBtn()
        configureGestureRecgonizer()
        configureConstraints()
    }
    
}

extension RegisterViewController {
    
    func configureTextFields() {
        let color = UIColor.lightGray.cgColor

        
        nameTextField.placeholder = "用户名"
        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        nameTextField.leftViewMode = .always
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self
        nameTextField.backgroundColor = UIColor(cgColor: color.copy(alpha: 0.12)!)
        nameTextField.layer.cornerRadius = view.bounds.width / 39
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        pswTextField.placeholder = "密码"
        pswTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        pswTextField.leftViewMode = nameTextField.leftViewMode
        pswTextField.clearButtonMode = .always
        pswTextField.returnKeyType = .next
        pswTextField.delegate = self
        pswTextField.backgroundColor = nameTextField.backgroundColor
        pswTextField.layer.cornerRadius = nameTextField.layer.cornerRadius
        pswTextField.isSecureTextEntry = true
        pswTextField.translatesAutoresizingMaskIntoConstraints = false
        
        confirmTextField.placeholder = "确认密码"
        confirmTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        confirmTextField.leftViewMode = nameTextField.leftViewMode
        confirmTextField.clearButtonMode = .always
        confirmTextField.returnKeyType = .go
        confirmTextField.delegate = self
        confirmTextField.backgroundColor = nameTextField.backgroundColor
        confirmTextField.layer.cornerRadius = nameTextField.layer.cornerRadius
        confirmTextField.isSecureTextEntry = pswTextField.isSecureTextEntry
        confirmTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureInputStackView() {
        inputStackView.axis = .vertical
        inputStackView.distribution = .equalCentering
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        inputStackView.alignment = .center
        
        let view1 = UIView()
        let view2 = UIView()
        
        inputStackView.addArrangedSubview(view1)
        inputStackView.addArrangedSubview(nameTextField)
        inputStackView.addArrangedSubview(pswTextField)
        inputStackView.addArrangedSubview(confirmTextField)
        inputStackView.addArrangedSubview(view2)
    }
    
    func configureRegBtn() {
        regBtn.setTitle("注册", for: .normal)
        regBtn.addTarget(self, action: #selector(reg), for: .touchUpInside)
        regBtn.backgroundColor = .systemBlue
        regBtn.setTitleColor(.white, for: .normal)
        regBtn.layer.cornerRadius = nameTextField.layer.cornerRadius
        regBtn.translatesAutoresizingMaskIntoConstraints = false
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
            inputStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputStackView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            
            pswTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            pswTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            
            confirmTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            confirmTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            
            regBtn.topAnchor.constraint(equalTo: inputStackView.bottomAnchor),
            regBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regBtn.heightAnchor.constraint(equalToConstant: 50),
            regBtn.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
        ]
        view.addConstraints(constraints)
    }
}


extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            pswTextField.becomeFirstResponder()
        } else if textField == pswTextField {
            pswTextField.resignFirstResponder()
            confirmTextField.becomeFirstResponder()
        } else {
            reg()
        }
        return true
    }
    
}

extension RegisterViewController {
    
    @objc func fireGesture(_ gestureRecgonizer: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        pswTextField.resignFirstResponder()
        confirmTextField.resignFirstResponder()
    }
    
    @objc func reg() {
        print("register")
        
        guard let name = nameTextField.text, name != "" else {
            presentOkAlert(title: "用户名为空", msg: "请输入用户名")
            return
        }
        
        guard let psw = pswTextField.text, psw != "" else {
            presentOkAlert(title: "密码为空", msg: "请输入密码")
            return
        }
        
        guard let con = confirmTextField.text, psw == con else {
            presentOkAlert(title: "密码不一致", msg: "请重新确认密码")
            return
        }
        guard let percentName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            presentOkAlert(title: "用户名不合法", msg: "请输入合法的用户名")
            return
        }
        let urlStr = urlPrefix + "/users/reg/" + percentName + "/" + psw
        guard let url = URL(string: urlStr) else {
            presentOkAlert(title: "内部错误", msg: "")
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
                self.presentOkAlert(title: "注册失败", msg: str)
                return
            }
            
            guard let u = try? JSONDecoder().decode(User.self, from: data) else {
                self.presentOkAlert(title: "内部错误", msg: "")
                return
            }
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "注册成功", message: "恭喜，注册成功！🎉", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.father.nameTextField.text = u.userName
                        self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
            
        }
        task.resume()
    }
}


