import UIKit
import SnapKit

class sticky: UIViewController {
    
    var tableView1HeightConstant: CGFloat = 400
    var tableView2HeightConstant: CGFloat = 400

     private let scrollView: UIScrollView = {
         let view = UIScrollView()
         view.backgroundColor = .white
         return view
     }()

     private let stackView: UIStackView = {
         let view = UIStackView()
         view.axis = .vertical
         return view
     }()
    
    private let nestedStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = -30
        return view
    }()

    private let cafeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "big_cafe")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    private let headerViewSegmentControl = UISegmentedControl()
    private let stickyHeaderViewSegmentControl = UISegmentedControl()

    private let cafeView = UIView()

    private let cafeName = UILabel()
    private let cafeLocation = UILabel()
    private let cafeLocationCheck =  UIButton()
    private let dottedLine = CAShapeLayer()
    private let path = CGMutablePath()


    private let reviewWriteButton =  UIButton()
    
    var isHeartSelected = false
    let heartButton = UIButton()
    let heartFillImage = UIImage(systemName: "heart.fill",
                                 withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    
    let heartEmptyImage = UIImage(systemName: "heart",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .medium))?.withTintColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), renderingMode: .alwaysOriginal)
    
    

    private let tableView1 = UITableView()
    private let tableView2 = UITableView()

    
    var cafeId : Int?

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = false
            // 네비게이션컨트롤러를 통해서 Status Bar 색깔 변경
            self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.tintColor = .black

            self.navigationController?.navigationBar.isTranslucent = true

            //fetchData() //setver에서 CafeInfoById를 front에 페치해야함, view did load전에
        }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.isNavigationBarHidden = true
        }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //print("!!!!!!!!!!!!!", cafeId)

        // UIScrollView 설정
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    
        cafeView.backgroundColor = .white
        cafeView.layer.cornerRadius = 30
        cafeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        let maskLayer = CAShapeLayer()
//        let cornerRadius: CGFloat = 15
//        maskLayer.path = UIBezierPath(roundedRect: cafeView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
//        cafeView.layer.mask = maskLayer

        cafeName.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        cafeName.text = "카페네임"
        cafeName.textAlignment = .left
        cafeName.translatesAutoresizingMaskIntoConstraints = false

        cafeLocation.font = UIFont.systemFont(ofSize: 15)
        cafeLocation.text = "카페위치"
        cafeLocation.textAlignment = .left
        cafeLocation.translatesAutoresizingMaskIntoConstraints = false
        
        // 버튼 설정
        cafeLocationCheck.setTitle("매장위치 확인>", for: .normal)
        cafeLocationCheck.setTitleColor(UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1), for: .normal)
        cafeLocationCheck.backgroundColor = .clear
        cafeLocationCheck.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        dottedLine.strokeColor = UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1).cgColor
        dottedLine.lineWidth = 2
        dottedLine.lineDashPattern = [6, 4] // [실선길이, 공백길이]를 반복하면서 그려 점선을 만듭니다.
        path.addLines(between: [CGPoint(x: 20, y: 100), CGPoint(x: 370, y: 100)]) // 점선을 그리고 싶은 좌표를 지정합니다.

        dottedLine.path = path // CAShapeLayer에 점선을 추가합니다.


        //edit button
        reviewWriteButton.translatesAutoresizingMaskIntoConstraints = false
        reviewWriteButton.clipsToBounds = true
        reviewWriteButton.backgroundColor = .black
        reviewWriteButton.layer.cornerRadius = 30
        reviewWriteButton.addTarget(self, action: #selector(reviewWriteButtonClicked), for: .touchUpInside)

        setSegmentControl()
        setTableView()
        setHeartButton()
        
        view.addSubview(scrollView)
        view.addSubview(stickyHeaderViewSegmentControl)
        scrollView.addSubview(stackView)
        nestedStackView.addArrangedSubview(cafeImage)
        nestedStackView.addArrangedSubview(cafeView)
        stackView.addArrangedSubview(nestedStackView)
        cafeView.addSubview(cafeName)
        cafeView.addSubview(cafeLocation)
        cafeView.addSubview(cafeLocationCheck)
        cafeView.addSubview(heartButton)
        cafeView.layer.addSublayer(dottedLine) // 점선을 추가한 CAShapeLayer를 yourView의 서브레이어로 추가합니다.

        stackView.addArrangedSubview(headerViewSegmentControl)
        //stackView.addArrangedSubview(label2)

        stackView.addArrangedSubview(tableView1)
        stackView.addArrangedSubview(tableView2)
        tableView2.addSubview(reviewWriteButton)
        


        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.bottom.right.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        cafeImage.snp.makeConstraints {
            $0.height.equalTo(250)
        }
        
        
        cafeView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
        
        stickyHeaderViewSegmentControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }

        headerViewSegmentControl.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        cafeName.snp.makeConstraints { make in
            make.leading.equalTo(cafeView.snp.leading).offset(30)
            make.top.equalTo(cafeView.snp.top).offset(30)
        }

        cafeLocation.snp.makeConstraints { make in
            make.leading.equalTo(cafeView.snp.leading).offset(30)
            make.top.equalTo(cafeName.snp.bottom).offset(8)
        }
        
        cafeLocationCheck.snp.makeConstraints { make in
            make.leading.equalTo(cafeName.snp.trailing).offset(15)
            make.top.equalTo(cafeView.snp.top).offset(33)
        }
        
        heartButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(325)
            make.top.equalTo(cafeView.snp.top).offset(35)
        }

    
        let numberOfRowsInTableView1 = tableView1.dataSource?.tableView(tableView1, numberOfRowsInSection: 0) ?? 0
        let numberOfRowsInTableView2 = tableView2.dataSource?.tableView(tableView2, numberOfRowsInSection: 0) ?? 0

        tableView1HeightConstant = CGFloat(numberOfRowsInTableView1 ) * 115
        tableView2HeightConstant = CGFloat(numberOfRowsInTableView2 ) * 115

    
        tableView1.snp.makeConstraints {
            $0.height.equalTo(tableView1HeightConstant).priority(.low)
        }
        
        tableView2.snp.makeConstraints {
            $0.height.equalTo(tableView2HeightConstant).priority(.low)
        }

        reviewWriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 650).isActive = true
        reviewWriteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 310).isActive = true
        reviewWriteButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        reviewWriteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true


        // 초기에는 첫 번째 세그먼트가 선택되도록 설정
        stickyHeaderViewSegmentControl.isHidden = true

        updateTableViewVisibility()
    }

    private func setHeartButton() {
        // 버튼 설정
        heartButton.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
        heartButton.setImage(heartEmptyImage, for: .normal)
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonTapped() {
        isHeartSelected = !isHeartSelected
        if isHeartSelected {
            heartButton.setImage(heartFillImage, for: .normal)

        } else {
            heartButton.setImage(heartEmptyImage, for: .normal)

        }
    }

    @objc private func segmentControlDidChangeValue(_ segmentControl: UISegmentedControl) {
        let selectedSegmentIndex = segmentControl.selectedSegmentIndex
        headerViewSegmentControl.selectedSegmentIndex = selectedSegmentIndex
        stickyHeaderViewSegmentControl.selectedSegmentIndex = selectedSegmentIndex
        
        updateTableViewVisibility()
    }
    
    private func updateTableViewVisibility() {
        if headerViewSegmentControl.selectedSegmentIndex == 0 {
            tableView1.isHidden = false
            tableView2.isHidden = true
        } else {
            tableView1.isHidden = true
            tableView2.isHidden = false
        }
    }
    
    func setSegmentControl(){
        // 세그먼트 컨트롤 설정
        headerViewSegmentControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        headerViewSegmentControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        headerViewSegmentControl.selectedSegmentIndex = 0

        headerViewSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        headerViewSegmentControl.backgroundColor = .white
        headerViewSegmentControl.tintColor = .red

        
        stickyHeaderViewSegmentControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        stickyHeaderViewSegmentControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        stickyHeaderViewSegmentControl.selectedSegmentIndex = 0

        stickyHeaderViewSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        stickyHeaderViewSegmentControl.backgroundColor = .white

        headerViewSegmentControl.addTarget(self, action: #selector(segmentControlDidChangeValue(_:)), for: .valueChanged)
        stickyHeaderViewSegmentControl.addTarget(self, action: #selector(segmentControlDidChangeValue(_:)), for: .valueChanged)
      

        // Change text color and the font of the NOT selected (normal) segment
        headerViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)

        // Change text color and the font of the selected segment
        headerViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
        
        
        // Change text color and the font of the NOT selected (normal) segment
        stickyHeaderViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)

        // Change text color and the font of the selected segment
        stickyHeaderViewSegmentControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
        
        removeBackgroundAndDivider()

    }
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        headerViewSegmentControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        headerViewSegmentControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        headerViewSegmentControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        headerViewSegmentControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        stickyHeaderViewSegmentControl.setBackgroundImage(image, for: .normal, barMetrics: .default)
        stickyHeaderViewSegmentControl.setBackgroundImage(image, for: .selected, barMetrics: .default)
        stickyHeaderViewSegmentControl.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        stickyHeaderViewSegmentControl.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
    }
    

    
    func setTableView(){
        // 테이블 뷰 설정
        tableView1.backgroundColor = .white
        tableView1.translatesAutoresizingMaskIntoConstraints = false

        tableView1.dataSource = self
        tableView1.delegate = self

        tableView2.backgroundColor = .white
        tableView2.translatesAutoresizingMaskIntoConstraints = false

        tableView2.dataSource = self
        tableView2.delegate = self

        
        tableView1.register(CafeDetailViewMenuCell.self, forCellReuseIdentifier: "CafeDetailViewMenuCell")
        tableView2.register(CafeDetailViewReviewCell.self, forCellReuseIdentifier: "CafeDetailViewReviewCell")
        
        tableView1.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView2.separatorStyle = UITableViewCell.SeparatorStyle.none


        
//        tableView1.separatorStyle = .none
//        tableView1.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//    
    }

//    func fetchData() { //result = getAllCafeInfo 실행해서 얻은 결과
//
//        guard let cafeId = cafeId else {
//            // cafeId가 nil일 경우에 대한 처리 로직
//            print("cafeId가 nil입니다.")
//            return
//        }
//
//        let detailcafeservice = DetailCafeService() // DetailCafeService 인스턴스 생성
//        detailcafeservice.getDetailCafeBycafeID(cafeID: 2) { result in
//            switch result {
//            case .success(let cafe):
//                // 성공적으로 데이터를 받아왔을 때의 처리 로직
//                print(cafe) // 받아온 데이터 사용 예시
//                // UI 업데이트 또는 필요한 작업 수행
//                DispatchQueue.main.async {
//                    self.cafeName.text = cafe.name // 받아온 데이터의 이름을 라벨에 설정
//                    self.cafeLocation.text = cafe.address
//
//                }
//            case .failure(let error):
//                // 데이터를 받아오지 못했을 때의 처리 로직
//                print(error.localizedDescription)
//                // 에러 메시지 출력 예시
//                // 에러 메시지를 보여줄 수 있는 방식으로 처리
//                print(error)
//            }
//        }
//
//        let detailcafemenuservice = DetailCafeMenuService()
//        detailcafemenuservice.getDetailCafeMenuBycafeID(cafeID: 2) { result in
//            switch result {
//            case .success(let cafe):
//                // 성공적으로 데이터를 받아왔을 때의 처리 로직
//                print(cafe) // 받아온 데이터 사용 예시
//                // UI 업데이트 또는 필요한 작업 수행
////                DispatchQueue.main.async {
////                }
//            case .failure(let error):
//                // 데이터를 받아오지 못했을 때의 처리 로직
//                print(error.localizedDescription)
//                // 에러 메시지 출력 예시
//                // 에러 메시지를 보여줄 수 있는 방식으로 처리
//                print(error)
//            }
//        }
//
//    }


    @objc func reviewWriteButtonClicked() {
        let nextVC = WriteReviewView()
        navigationController?.pushViewController(nextVC, animated: true)
        //present(nextVC, animated: true, completion: nil)
    }


}

extension sticky: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return 10 // 첫 번째 테이블 뷰에는 10개의 셀을 표시
        } else if tableView == tableView2 {
            return 20 // 두 번째 테이블 뷰에는 5개의 셀을 표시
        } else {
            return 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CafeDetailViewMenuCell", for: indexPath) as! CafeDetailViewMenuCell
            cell.selectionStyle = .none

            return cell
        } else if tableView == tableView2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CafeDetailViewReviewCell", for: indexPath) as! CafeDetailViewReviewCell
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableView1 {
            return 115
        } else if tableView == tableView2 {
            return 115
        }
        return 0
    }
//
//    func tableView(_ tableView: UITableView, widthForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView == tableView1 {
//            return 115
//        } else if tableView == tableView2 {
//            return 115
//        }
//        return 0
//
//    }
}

extension sticky: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y: 손가락을 위로 올리면 + 값, 손가락을 아래로 내리면 - 값
        print(scrollView.contentOffset.y, headerViewSegmentControl.frame.minY)
        
        // 5. 핵심 - frame.minY를 통해 sticky 타이밍을 계산
        let shouldShowSticky = scrollView.contentOffset.y >= headerViewSegmentControl.frame.minY
        stickyHeaderViewSegmentControl.isHidden = !shouldShowSticky
    }
}
