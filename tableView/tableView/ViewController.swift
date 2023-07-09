import UIKit
import SnapKit

class CafeDetailView: UIViewController {
    private let scrollView = UIScrollView()
    private let parallaxImageView = UIImageView()
    private let headerView = UIView()
    private let cafeName = UILabel()
    private let cafeLocation = UILabel()
    private let reviewWriteButton =  UIButton()

    private let segmentedControl = UISegmentedControl()
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
        
            fetchData() //setver에서 CafeInfoById를 front에 페치해야함, view did load전에
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
        
        // 피럴랙스 효과를 가진 이미지 설정
        parallaxImageView.image = UIImage(named: "big_cafe") // 피럴랙스 이미지 설정
        parallaxImageView.contentMode = .scaleAspectFill
        parallaxImageView.clipsToBounds = true
        parallaxImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 헤더뷰 설정
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        

        cafeName.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        cafeName.textAlignment = .left
        cafeName.translatesAutoresizingMaskIntoConstraints = false

        cafeLocation.font = UIFont.systemFont(ofSize: 15)
        cafeLocation.textAlignment = .left
        cafeLocation.translatesAutoresizingMaskIntoConstraints = false
        
        //edit button
        reviewWriteButton.translatesAutoresizingMaskIntoConstraints = false
        reviewWriteButton.backgroundColor = .black
        reviewWriteButton.layer.cornerRadius = 20
        reviewWriteButton.setTitle("리뷰쓰기", for: .normal)
        reviewWriteButton.addTarget(self, action: #selector(reviewWriteButtonClicked), for: .touchUpInside)

        // 세그먼트 컨트롤 설정
        segmentedControl.insertSegment(withTitle: "카페 메뉴", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "평점 및 후기", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        segmentedControl.backgroundColor = .white

        
        // Change text color and the font of the NOT selected (normal) segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .normal)

        // Change text color and the font of the selected segment
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.45, blue: 0.356, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
    
        // 테이블 뷰 설정
        tableView1.backgroundColor = .white
        tableView1.translatesAutoresizingMaskIntoConstraints = false
        
        tableView1.dataSource = self
        tableView1.delegate = self

        tableView2.backgroundColor = .white
        tableView2.translatesAutoresizingMaskIntoConstraints = false
        
        tableView2.dataSource = self
        tableView2.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(parallaxImageView)
        scrollView.addSubview(headerView)
        headerView.addSubview(cafeName)
        headerView.addSubview(cafeLocation)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(tableView1)
        scrollView.addSubview(tableView2)
        tableView2.addSubview(reviewWriteButton)


        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
              
        // 피럴랙스 효과를 가진 이미지 설정
        parallaxImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(scrollView)
            make.height.equalTo(250)
            make.width.equalTo(scrollView.snp.width)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(parallaxImageView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        // 첫 번째 라벨 제약조건 설정
        cafeName.snp.makeConstraints { make in
            make.leading.equalTo(headerView.snp.leading).offset(30)
            make.top.equalTo(headerView.snp.top).offset(16)
        }
        
        // 두 번째 라벨 제약조건 설정
        cafeLocation.snp.makeConstraints { make in
            make.leading.equalTo(headerView.snp.leading).offset(30)
            make.top.equalTo(cafeName.snp.bottom).offset(8)
        }
        
        
        segmentedControl.snp.makeConstraints{ make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        // 콘텐츠 높이 설정
        //scrollView.contentSize = CGSize(width: view.bounds.width, height: 400)
        
        tableView1.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        //tableView1.alwaysBounceVertical = false
        //tableView1.isUserInteractionEnabled = false // 테이블뷰 스크롤 막기
        
        tableView2.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        //tableView2.isUserInteractionEnabled = false // 테이블뷰 스크롤 막기
        tableView1.isUserInteractionEnabled = false
        tableView2.isUserInteractionEnabled = false
        
        tableView1.bounces = false
        tableView2.bounces = false

        tableView1.register(CafeDetailViewMenuCell.self, forCellReuseIdentifier: "CafeDetailViewMenuCell")
        tableView2.register(CafeDetailViewReviewCell.self, forCellReuseIdentifier: "CafeDetailViewReviewCell")

        reviewWriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600).isActive = true
        reviewWriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        reviewWriteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        reviewWriteButton.widthAnchor.constraint(equalToConstant: 300).isActive = true

        // 초기에는 첫 번째 세그먼트가 선택되도록 설정
        updateTableViewVisibility()
        
        //scrollView.updateContentSize()
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        updateTableViewVisibility()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if segmentedControl.selectedSegmentIndex == 0 {
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 250 + 100 + 100*2)

            //scrollView.contentSize.height = 250 + 100 + 100*2
        }else{
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: 250 + 100 + 100*5)
        }
            
    }
    

    func fetchData() { //result = getAllCafeInfo 실행해서 얻은 결과
        
        guard let cafeId = cafeId else {
            // cafeId가 nil일 경우에 대한 처리 로직
            print("cafeId가 nil입니다.")
            return
        }
        
        let detailcafeservice = DetailCafeService() // DetailCafeService 인스턴스 생성
        detailcafeservice.getDetailCafeBycafeID(cafeID: cafeId) { result in
            switch result {
            case .success(let cafe):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                print(cafe) // 받아온 데이터 사용 예시
                // UI 업데이트 또는 필요한 작업 수행
                DispatchQueue.main.async {
                    self.cafeName.text = cafe.name // 받아온 데이터의 이름을 라벨에 설정
                    self.cafeLocation.text = cafe.address

                }
            case .failure(let error):
                // 데이터를 받아오지 못했을 때의 처리 로직
                print(error.localizedDescription)
                // 에러 메시지 출력 예시
                // 에러 메시지를 보여줄 수 있는 방식으로 처리
                print(error)
            }
        }
        
        let detailcafemenuservice = DetailCafeMenuService()
        detailcafemenuservice.getDetailCafeMenuBycafeID(cafeID: 2) { result in
            switch result {
            case .success(let cafe):
                // 성공적으로 데이터를 받아왔을 때의 처리 로직
                print(cafe) // 받아온 데이터 사용 예시
                // UI 업데이트 또는 필요한 작업 수행
//                DispatchQueue.main.async {
//                }
            case .failure(let error):
                // 데이터를 받아오지 못했을 때의 처리 로직
                print(error.localizedDescription)
                // 에러 메시지 출력 예시
                // 에러 메시지를 보여줄 수 있는 방식으로 처리
                print(error)
            }
        }

    }

    
    @objc func reviewWriteButtonClicked() {
        let nextVC = WriteReviewView()
        navigationController?.pushViewController(nextVC, animated: true)
        //present(nextVC, animated: true, completion: nil)
    }


    private func updateTableViewVisibility() {
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView1.isHidden = false
            tableView2.isHidden = true
        } else {
            tableView1.isHidden = true
            tableView2.isHidden = false
        }
    }
}

extension CafeDetailView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
            return 2 // 첫 번째 테이블 뷰에는 10개의 셀을 표시
        } else if tableView == tableView2 {
            return 5 // 두 번째 테이블 뷰에는 5개의 셀을 표시
        } else {
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CafeDetailViewMenuCell", for: indexPath) as! CafeDetailViewMenuCell
            //cell.textLabel?.text = "Row \(indexPath.row + 1)"
            return cell
        } else if tableView == tableView2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CafeDetailViewReviewCell", for: indexPath) as! CafeDetailViewReviewCell
            // Configure the cell with the review data
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 높이 설정
        return 100
    }
    


}
