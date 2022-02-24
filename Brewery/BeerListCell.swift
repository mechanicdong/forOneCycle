//
//  BeerListCell.swift
//  Brewery
//
//  Created by 이동희 on 2022/02/22.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListCell: UITableViewCell {
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    
    //Cell의 ContentView에 추가
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, taglineLabel].forEach {
            contentView.addSubview($0)
        }
        
        //Components attributes setting
        beerImageView.contentMode = .scaleAspectFit
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 2
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        //Components autolayout setting
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview() //부모뷰에 맞추기
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        taglineLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).inset(5)
        }
    }
    
    //Cell의 외부에서 Data를 전달하는 함수
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")
        //Kingfisher를 통해 Image를 전달
        beerImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        
        //Cell 우측 꺽새모양 화살표
        accessoryType = .disclosureIndicator
        //Cell을 Tap해도 음영 미발생
        selectionStyle = .none
    }
}
