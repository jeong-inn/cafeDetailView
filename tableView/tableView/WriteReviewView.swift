//
//  WriteReviewView.swift
//  CaZait-iOS
//
//  Created by J on 2023/05/22.
//

import UIKit
import SnapKit


class WriteReviewView: UIViewController{
   
//    var navBar: UINavigationBar = UINavigationBar()
        
    let title1: UILabel = {
        let text = UILabel()
        text.text = "리뷰쓰기"
        text.textColor = .white
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .boldSystemFont(ofSize: 25)
        return text
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //카페는 어떠셨나요? 별점을 남겨주세요.
    let text1: UILabel = {
        let text1 = UILabel()
        text1.text = "카페는 어떠셨나요? 별점을 남겨주세요."
        text1.textColor = .black
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.font = .italicSystemFont(ofSize: 15)
        return text1
    }()
    
    lazy var rateView: RateView = {
        let view = RateView()

        return view
    }()

    
    private lazy var hstackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    //카페는 어떠셨나요? 별점을 남겨주세요.
    let text2: UILabel = {
        let text2 = UILabel()
        text2.text = "다른 이용자를 위해 카페 리뷰를 남겨주세요."
        text2.textColor = .black
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.font = .italicSystemFont(ofSize: 15)
        return text2
    }()
    

//    let textfield1: InsetTextField = {
//
//        let textField = InsetTextField();
//
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "공백 포함 최대 50자 이내로 작성해주세요."
//        textField.setPlaceholder(color: UIColor(red: 0.708, green: 0.708, blue: 0.708, alpha: 1))
//        textField.backgroundColor = .white
//        textField.layer.cornerRadius = 25
//        //textField.setPlaceholder(color: UIColor(r: 93, g: 36, b: 36))
//        textField.insetX = 47.25
//        textField.textColor = .black
//        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor(red: 0.363, green: 0.142, blue: 0.142, alpha: 1).cgColor
//
//        return textField
//
//    }()
    
    let textfield1: UILabel = {
        let text2 = UILabel()
        text2.text = "다른 이용자를 위해 카페 리뷰를 남겨주세요."
        text2.textColor = .black
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.font = .italicSystemFont(ofSize: 15)
        return text2
    }()

    
    let placeholder = "공백 포함 최대 50자 이내로 작성해주세요."

    var activityTextView: UITextView{
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .italicSystemFont(ofSize: 14)
        text.backgroundColor = .white
        text.layer.borderWidth = 0  // 테두리 없애기
//        text.tintColor = UIColor(red: 0.363, green: 0.142, blue: 0.142, alpha: 1)
        text.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        return text

     }

    let text3: UILabel = {
        let text = UILabel()
        text.text = "0/50"
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .italicSystemFont(ofSize: 14)
        return text
    }()
    
    //작성하기
    let button1: UIButton = {
        var button1 = UIButton()
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.backgroundColor = .black
        button1.imageView?.contentMode = .scaleAspectFit
        button1.layer.cornerRadius = 20
        button1.setTitle("작성하기", for: .normal)
        button1.setTitleColor(.white, for: .normal)
//        button1.layer.shadowColor = UIColor.gray.cgColor
//        button1.layer.shadowOpacity = 1.0
//        button1.layer.shadowRadius = 6
//        button1.layer.shadowOffset = CGSize(width: 0, height: 5)
        return button1
    }()
    

    override func viewDidLoad(){
        super.viewDidLoad()
        

//        self.setNavBarToTheView()
        self.setTitleView()
//        setupAutoLayout()
//        setupTextView()
        
        view.backgroundColor = UIColor(red: 1, green: 0.873, blue: 0.852, alpha: 1)

        
        self.view.addSubview(label1)
        label1.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top)
            maker.height.equalTo(80)
            maker.width.equalTo(view.snp.width)
        }

        
        self.view.addSubview(text1)
        text1.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            maker.leading.equalTo(view.snp.leading).offset(37)
        }
        

        self.view.addSubview(rateView)
        rateView.translatesAutoresizingMaskIntoConstraints = false
        rateView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rateView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true


        self.view.addSubview(text2)
        text2.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(235)
            maker.leading.equalTo(view.snp.leading).offset(37)
        }

        self.view.addSubview(textfield1)
        textfield1.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(268)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(335)
            maker.height.equalTo(163)
        }
        
        
        self.view.addSubview(button1)
        button1.snp.makeConstraints { maker in
            maker.top.equalTo(view.snp.top).offset(475)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(150)
            maker.height.equalTo(46)
        }
        
        self.view.addSubview(title1)
        title1.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            maker.centerX.equalToSuperview()
        }

    }

    
//    func setNavBarToTheView() {
//        UINavigationBar.appearance().isTranslucent = false
//        self.navBar.frame = CGRectMake(0, 0, 393, 106)
//        self.navBar.backgroundColor = UIColor(red: 0.363, green: 0.142, blue: 0.142, alpha: 1)
//        self.view.addSubview(navBar)
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) /// 화면을 누르면 키보드 내려가게 하는 것
    }
    
    func setTitleView(){
        let titleName = UILabel()
        titleName.text = "리뷰쓰기"
        titleName.font = UIFont.boldSystemFont(ofSize: 20)
        titleName.textColor = .white
        titleName.sizeToFit()
        
        navigationItem.titleView = titleName
    }
}


