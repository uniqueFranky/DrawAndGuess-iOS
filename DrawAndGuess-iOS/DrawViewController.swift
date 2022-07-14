//
//  ViewController.swift
//  DAG
//
//  Created by Mac on 2022/7/13.
//

import UIKit

class ViewController: UIViewController {
    let canvas = Canvas()
    override func loadView() {
        self.view=canvas
    }
    let undoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlerUndo), for: .touchUpInside)
        return button
    }()
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    let yellowButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        return button
    }()
    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    let greenButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .green
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    let blackButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        return button
    }()
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 20
        slider.addTarget(self, action: #selector(changeWidth), for: .valueChanged)
        return slider
    }()
    @objc func handlerUndo() {
        canvas.undo()
    }
    @objc func handleClear() {
        canvas.clear()
    }
    @objc func changeColor(button: UIButton) {
        canvas.changeColor(color: button.backgroundColor ?? .black)
    }
    @objc func changeWidth() {
        canvas.changeWidth(width: Int(slider.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forceOrientationLandscape()
        canvas.backgroundColor = .white
        setUpStackView()
        // Do any additional setup after loading the view.
    }
    
    //横屏显示
    func forceOrientationLandscape() {
            let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.isForceLandscape = true
            appdelegate.isForcePortrait = false
            _ = appdelegate.application(UIApplication.shared, supportedInterfaceOrientationsFor: self.view.window)
            let oriention = UIInterfaceOrientation.landscapeRight // 设置屏幕为横屏
            UIDevice.current.setValue(oriention.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
    }
    //竖屏显示
    func forceOrientationPortrait() {
            let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appdelegate.isForceLandscape = false
            appdelegate.isForcePortrait = true
            _ = appdelegate.application(UIApplication.shared, supportedInterfaceOrientationsFor: self.view.window)
            let oriention = UIInterfaceOrientation.portrait // 设置屏幕为竖屏
            UIDevice.current.setValue(oriention.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
    
    func setUpStackView(){
        let colorStackView = UIStackView(arrangedSubviews:
                                            [redButton,
                                            yellowButton,
                                            blueButton,
                                            greenButton,
                                            blackButton])
        colorStackView.distribution = .fillEqually
        let stackView = UIStackView(arrangedSubviews: [undoButton,clearButton,colorStackView,slider])
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive=true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive=true
    }


}

