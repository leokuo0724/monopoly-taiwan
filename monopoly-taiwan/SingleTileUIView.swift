//
//  SingleTileUIView.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/29.
//

import UIKit

class SingleTileUIView: UIView {
    let tileIndex: Int
    let touchFunc: () -> Void
    var tileImage: UIImageView?
    
    init?(frame: CGRect, tileIndex: Int, touchFunc: @escaping () -> Void) {
        self.tileIndex = tileIndex
        self.touchFunc = touchFunc
        super.init(frame: frame)
        self.tileImgInit()
        self.setInteractive()
    }
    
    required init?(coder: NSCoder) {
        fatalError("SingleTileUIView init incomplete")
    }
    
    private func tileImgInit() {
        self.tileImage = UIImageView()
        if let tileImage = self.tileImage {
            tileImage.image = UIImage(named: "tile")
            tileImage.frame = CGRect(x: 0, y: 0, width: 96, height: 54)
            tileImage.contentMode = .scaleAspectFit
            self.addSubview(tileImage)
        }
    }
    
    private func setInteractive() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.touchAction))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func touchAction(_ sender:UITapGestureRecognizer) {
        if let building = buildingInfoData[self.tileIndex] {
            currentInfo = building
        } else {
            currentInfo = nil
        }
        self.touchFunc()
    }
    
    func setTileImg() {
        if let tileImage = self.tileImage,
           let building = buildingInfoData[self.tileIndex] {
            if building.owner == "玩家" {
                tileImage.image = UIImage(named: "tile-玩家")
            } else if building.owner == "電腦" {
                tileImage.image = UIImage(named: "tile-電腦")
            } else {
                tileImage.image = UIImage(named: "tile")
            }
        }
    }
    
    func setBuildingImg(name: String?) {
        if let name = name {
            let buildingImage = UIImageView()
            buildingImage.image = UIImage(named: name)
            buildingImage.contentMode = .scaleAspectFit
            buildingImage.frame = CGRect(x: (96-54)/2, y: -18, width: 54, height: 54)
            self.addSubview(buildingImage)
        }
    }

}
