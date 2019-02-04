//
//  ViewController.swift
//  VK_Anna_Ershova
//
//  Created by Anna Ershova on 17/12/2018.
//  Copyright © 2018 Anna Ershova. All rights reserved.
//

import UIKit


class LoginFormController: UIViewController {
    @IBOutlet weak var cloudUIView: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var newIndicatorLoad: NewIndicatorView!
    
    @IBOutlet weak var loadingLogin: LoadingIndicatorView!
    
    
    let shapeLayer = CAShapeLayer()
    let shapeLayerTwo = CAShapeLayer()
    
//    //cloud
    let cloudView = CloudIndicatorAnimation()


    lazy var refreshView: RefreshView = {
        let view = RefreshView()

        //view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
//    endCloud
    
    
    
    
    var timerLoading = 3
    //очистка логина и пароля
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loginTextField.text = ""
        passwordTextField.text = ""
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.timerLoading -= 1
            if self.timerLoading == 0 {
                timer.invalidate()
                self.loadingLogin.removeFromSuperview()
                self.view.alpha = 1
            }
        }
        
        
        

       
        // loadingLogin.startAnimating()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        //loadingLogin.stopAnimating()
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.fromValue = 0.0
        animation.byValue = 1
        animation.duration = 4
        animation.repeatCount = Float.infinity
        
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        
        
        
        shapeLayer.add(animation, forKey: "drawLineAnimation")
        

        
//        let animated = CABasicAnimation(keyPath: "strokeEnd")
//
//        animated.fromValue = 1
//        animated.byValue = 0
//        animated.duration = 2
//        animated.repeatCount = Float.infinity
//
//        animated.fillMode = CAMediaTimingFillMode.forwards
//        animated.isRemovedOnCompletion = false
//        shapeLayerTwo.add(animation, forKey: nil)




        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе -- когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        //to draw
        
        shapeLayer.path = UIBezierPath(heartIn: CGRect(x: 2, y: 2, width: 100, height: 100)).cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        newIndicatorLoad.layer.addSublayer(shapeLayer)
        
        
        shapeLayerTwo.path = UIBezierPath(heartIn: CGRect(x: 2, y: 2, width: 100, height: 100)).cgPath
        shapeLayerTwo.strokeColor = UIColor.white.cgColor
        shapeLayerTwo.fillColor = UIColor.clear.cgColor
        shapeLayerTwo.lineWidth = 2.0
        shapeLayerTwo.lineCap = CAShapeLayerLineCap.round
        
        newIndicatorLoad.layer.addSublayer(shapeLayerTwo)
        

        
        
        //cloudSubview

        
        
        view.addSubview(cloudView)
        view.addSubview(refreshView)
        

        
        
    }
    
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    //
    //    @objc func editingChanged(){
    //        guard let login = loginTextField.text, let password = passwordTextField.text else {
    //            return
    //        }
    //        if login.isEmpty || password.isEmpty {
    //        }
    //
    //    }
    
    
    
    //    @IBAction func loginButtonPressed(_ sender: Any) {
    //        // Получаем текст логина
    //        let login = loginTextField.text!
    //        
    //        
    //        // Проверяем, верны ли они
    //        if login == "admin" {
    //            print("верный логин")
    //        } else {
    //            print("ошибка")
    //        }
    //    }
    
    
    
    
    @IBAction func exit(_ sender: AnyObject) {
        
        if let exit = navigationController {
            exit.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверяем данные
        let checkResult = checkUserData()
        
        // Если данные неверны, покажем ошибку
        if !checkResult {
            showLoginError()
        }
        // Вернем результат
        return checkResult
    }
    
    
    
    func checkUserData() -> Bool {
        
        let login = loginTextField.text!
        let password = passwordTextField.text!
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    
    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Error", message: "Invalid user data", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
        viewWillAppear(true) // поля входа пустые снова
        
    }
    
    
    
    
    
}



