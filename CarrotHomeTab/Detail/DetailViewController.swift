//
//  DetailViewController.swift
//  CarrotHomeTab
//
//  Created by 백소망 on 2022/09/23.
//

import UIKit
import Combine
import Kingfisher

// - ItemInfo -> 서버에서 postID를 이용해 추가 정보 가져오기

// - 상단 네비게이션 바 rightbarbuttonitem
// - 하단 채팅하기 뷰 작업완료


class DetailViewController: UIViewController {
    
    // User
    @IBOutlet weak var userThumbnail: UIImageView!
    @IBOutlet weak var userNickName: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userTemperature: UILabel!
    
    // Item
    @IBOutlet weak var itemThumbnail: UIImageView!
    @IBOutlet weak var itemInfoTitle: UILabel!
    @IBOutlet weak var itemInfoDescription: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var viewModel: DetailViewModel!
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureNaviagationBar()
        bind()
        viewModel.fetch()
    }
    
    private func setupUI() {
        userThumbnail.layer.masksToBounds = true
        userThumbnail.layer.cornerRadius = 40
    }
    
    private func bind() {
        viewModel.$itemInfoDetails
            .compactMap{ $0 }       // nil 제거
            .receive(on: RunLoop.main)
            .sink { details in
                self.userThumbnail.kf.setImage(with: URL(string: details.user.thumnail))
                self.userNickName.text = details.user.name
                self.userLocation.text = details.user.location
                self.userTemperature.text = "\(details.user.temperature)°C"
                self.itemThumbnail.kf.setImage(with: URL(string: details.item.thumbnailURL))
                self.itemInfoTitle.text = details.item.title
                self.itemInfoDescription.text = details.details.descriptions
                self.itemPriceLabel.text = "\(self.formatNumber(details.item.price))원"
            }.store(in: &subscriptions)
    }
    private func configureNaviagationBar() {
        
        let moreConfig = CustomBarItemConfiguration(
            image: UIImage(systemName: "ellipsis"),
            handler: { print("---> more tapped") })
        let moreItem = UIBarButtonItem.generate(with: moreConfig, width: 30)
        
        let shareConfig = CustomBarItemConfiguration(
            image: UIImage(systemName: "square.and.arrow.up"),
            handler: { print("---> share tapped") })
        let shareItem = UIBarButtonItem.generate(with: shareConfig, width: 30)
        
        navigationItem.rightBarButtonItems = [moreItem, shareItem]
        navigationItem.backButtonDisplayMode = .minimal     // 타이틀 말고 아이콘만 보여짐
    }


}

extension DetailViewController {
    private func formatNumber(_ price: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let result = formatter.string(from: NSNumber(integerLiteral: price)) ?? ""
        return result
    }
}
