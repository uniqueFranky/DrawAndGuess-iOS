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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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


}


//Configuration Functions
extension LoginViewController {
    func configureLoginBtn() {
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.backgroundColor = .systemBlue
        loginBtn.layer.cornerRadius = 10
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
        print("login")
    }
    
    @objc func reg() {
        print("register")
    }
    
    @objc func fireGesture(_ gestureRecgonizer: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        pswTextField.resignFirstResponder()
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
