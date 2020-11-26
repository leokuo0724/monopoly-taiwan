//
//  ViewController.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/23.
//

import UIKit



class BuildingInfo: Codable {
    let index: Int
    let name: String
    let levelCostInfo: Array<Int>
    let roadTollInfo: Array<Int>
    var owner: String
    var level: Int
    
    init(index: Int,
         name: String,
         levelCostInfo: Array<Int>,
         roadTollInfo: Array<Int>,
         owner: String,
         level: Int) {
        self.index = index
        self.name = name
        self.levelCostInfo = levelCostInfo
        self.roadTollInfo = roadTollInfo
        self.owner = owner
        self.level = level
    }
}
class PlayerStatus {
    let name: String
    var currentPosition: Int = 0
    var money: Int = 1000
    var actioned: Bool = false
    
    init(name: String) {
        self.name = name
    }
}

let buildingInfoData: Array<BuildingInfo?> = [
    nil,
    BuildingInfo(index: 1 ,name: "赤崁樓", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 2, name: "林百貨", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 3, name: "八五大樓", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 4, name: "合興車站", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 5, name: "國父紀念館", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 6, name: "安平古堡", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 7, name: "巴比倫空中花園", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 8, name: "慶修院", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 9, name: "成大榕園", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 10, name: "新埔柿餅工廠", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 11, name: "巨石陣", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 12, name: "成大牌坊", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 13, name: "黑帝斯神殿", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 14, name: "教堂", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0),
    BuildingInfo(index: 15, name: "中目黑星巴克", levelCostInfo: [100, 500, 2000], roadTollInfo: [0, 50, 100, 500], owner: "無", level: 0)
]

var currentInfo: BuildingInfo?
// 擲骰 -> 玩家 -> 電腦
var currentRound: String = "擲骰"
var isCanNextRound: Bool = true

var playerStatus = PlayerStatus(name: "玩家")
var computerStatus = PlayerStatus(name: "電腦")

let chessPlayer = UIImageView()
let chessComputer = UIImageView()

var tileUIViewG: UIView?
var infoCardG: UIView?
var playerMoneyG: UILabel?
var computerMoneyG: UILabel?
var infoCardImgG: UIImageView?
var infoCardOwnerG: UILabel?
var infoCardCurrentTollG: UILabel?
var infoCardNextTollG: UILabel?
var infoCardBuildingTitleG: UILabel?
var infoCardBuyBtnG: UIButton?

class ViewController: UIViewController {

    @IBOutlet weak var tileUIView: UIView!
    @IBOutlet weak var infoCard: UIView!
    @IBOutlet weak var playerMoney: UILabel!
    @IBOutlet weak var computerMoney: UILabel!
    @IBOutlet weak var infoCardImg: UIImageView!
    @IBOutlet weak var infoCardOwner: UILabel!
    @IBOutlet weak var infoCardCurrentToll: UILabel!
    @IBOutlet weak var infoCardNextToll: UILabel!
    @IBOutlet weak var infoCardBuildingTitle: UILabel!
    @IBOutlet weak var infoCardUpperView: UIView!
    @IBOutlet weak var infoCardBuyBtn: UIButton!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var roundImageView: UIImageView!
    @IBOutlet weak var diceImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set global indicator
        tileUIViewG = tileUIView
        infoCardG = infoCard
        playerMoneyG = playerMoney
        computerMoneyG = computerMoney
        infoCardImgG = infoCardImg
        infoCardOwnerG = infoCardOwner
        infoCardCurrentTollG = infoCardCurrentToll
        infoCardNextTollG = infoCardNextToll
        infoCardBuildingTitleG = infoCardBuildingTitle
        infoCardBuyBtnG = infoCardBuyBtn
        
        // 背景樣式初始化
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [CGColor(srgbRed: 198/255, green: 255/255, blue: 221/255, alpha: 1), CGColor(srgbRed: 251/255, green: 215/255, blue: 134/255, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 卡片樣式初始化
        self.infoCardInit()
        
        // 地板樣式初始化
        for i in 0..<buildingInfoData.count {
            let centerHorizon = tileUIView.center.y
            
            let singleTile = SingleTileUIView()
            singleTile.customizeInit(index: i)
            if let name = buildingInfoData[i]?.name {
                singleTile.setBuildingImg(name: name)
            }
            
            if i <= 4 {
                singleTile.frame = CGRect(x: centerHorizon - CGFloat(48 * i), y: CGFloat(24 * (i + 1)), width: 96, height: 54)
                tileUIView.insertSubview(singleTile, at: i)
            } else if i > 4, i <= 8 {
                singleTile.frame = CGRect(x: centerHorizon + CGFloat(48 * (i - 8)), y: CGFloat(24 * (i + 1)), width: 96, height: 54)
                tileUIView.insertSubview(singleTile, at: i)
            } else if i > 8, i <= 12 {
                singleTile.frame = CGRect(x: centerHorizon + CGFloat(48 * (i - 8)), y: CGFloat(24 * (-i + 17)), width: 96, height: 54)
                tileUIView.insertSubview(singleTile, at: 16-i)
            } else if i > 12, i <= 15 {
                singleTile.frame = CGRect(x: centerHorizon + CGFloat(48 * (-i + 16)), y: CGFloat(24 * (-i + 17)), width: 96, height: 54)
                tileUIView.insertSubview(singleTile, at: 16-i)
            }
        }
        
        // 棋子樣式初始化
        chessComputer.frame = CGRect(x: 0, y: 0, width: 25, height: 50)
        chessComputer.image = UIImage(named: "電腦")
        tileUIView.addSubview(chessComputer)
        chessPlayer.frame = CGRect(x: 0, y: 0, width: 25, height: 50)
        chessPlayer.image = UIImage(named: "玩家")
        tileUIView.addSubview(chessPlayer)
        
        // 骰子動畫初始化
        var diceImages = [UIImage]()
        for i in 1...6 {
            diceImages.append(UIImage(named: "dice-\(i)")!)
        }
        diceImageView.animationImages = diceImages
        diceImageView.animationDuration = 1
        diceImageView.animationRepeatCount = 2
        diceImageView.image = diceImages.last
        
        // 資料整體初始化
        dataInitialize()
    }
    
    func dataInitialize() {
        let actioned = false
        let initPos = 0
        let initMoney = 1000
        playerStatus.actioned = actioned
        playerStatus.currentPosition = initPos
        playerStatus.money = initMoney
        computerStatus.actioned = actioned
        computerStatus.currentPosition = initPos
        computerStatus.money = initMoney
        
        buildingInfoData.forEach { building in
            if let building = building {
                building.level = 0
                building.owner = "無"
            }
        }
        currentRound = "擲骰"
        currentInfo = nil
        
        self.viewInitialize()
    }
    func viewInitialize() {
        setMoney()
        setChessPosition()
        setRoundView()
        setInfoCardView()
    }
    
    func infoCardInit() {
        infoCard.layer.cornerRadius = 12
        infoCard.layer.shadowColor = UIColor.black.cgColor
        infoCard.layer.shadowOpacity = 0.4
        infoCard.layer.shadowRadius = 10
        infoCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        infoCardUpperView.clipsToBounds = true
        infoCardUpperView.layer.cornerRadius = 12
        infoCardUpperView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // 關閉建築資訊卡片
    @IBAction func closeInfoCard(_ sender: Any) {
        currentInfo = nil
        setInfoCardView()
    }
    
    // 購買建築
    @IBAction func buyBuilding(_ sender: Any) {
        self.purchase()
        // 更新畫面: 卡片、金錢
        setInfoCardView()
    }
    func purchase() {
        if currentRound == "玩家", currentInfo!.owner != "電腦" {
            // 初次購買
            if currentInfo!.owner == "無" {
                currentInfo!.owner = currentRound
            }
            playerStatus.money -= currentInfo!.levelCostInfo[currentInfo!.level]
            currentInfo!.level += 1
            playerStatus.actioned = true
            setMoney()
        } else if currentRound == "電腦", currentInfo!.owner != "玩家" {
            // 初次購買
            if currentInfo!.owner == "無" {
                currentInfo!.owner = currentRound
            }
            computerStatus.money -= currentInfo!.levelCostInfo[currentInfo!.level]
            currentInfo!.level += 1
            computerStatus.actioned = true
            setMoney()
        }
    }
    
    // 下一回合
    @IBAction func nextRound(_ sender: Any) {
        guard isCanNextRound == true else {
            return
        }
        isCanNextRound = false
        // now round: 電腦 set to 玩家 round
        if (currentRound == "擲骰") { // 玩家擲骰子
            currentRound = "玩家"
            setRoundView()
            self.dice(role: playerStatus)
        } else if (currentRound == "玩家") { // 玩家結束動作給電腦
            currentRound = "電腦"
            setRoundView()
            self.dice(role: computerStatus)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // 判斷電腦可否買
                if let currentInfo = currentInfo,
                   computerStatus.money >= currentInfo.levelCostInfo[currentInfo.level],
                   currentInfo.owner != "玩家" {
                    self.purchase()
                }
                currentRound = "擲骰"
                self.setRoundView()
                isCanNextRound = true
            }
        }
    }
    // 設定回合顯示
    func setRoundView() {
        roundLabel.text = "\(currentRound)回合"
        if currentRound == "電腦" {
            roundLabel.backgroundColor = UIColor(named: "ComputerColor")
        } else {
            roundLabel.backgroundColor = UIColor(named: "PlayerColor")
        }
        roundImageView.image = UIImage(named: currentRound)
        roundImageView.contentMode = .scaleAspectFit
    }
    func dice(role: PlayerStatus) {
        let roleName: String = role.name
        
        role.actioned = false
        let number = Int.random(in: 1...6)
        
        // 播放骰子動畫
        diceImageView.startAnimating()
        
        // 等待骰子動畫
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.diceImageView.image = UIImage(named: "dice-\(number)")
            role.currentPosition += number
            if role.currentPosition > 15 {
                role.currentPosition -= 16
            }
            setChessPosition()
            // 設定當前卡片
            currentInfo = buildingInfoData[role.currentPosition]
            if currentRound == "玩家" {
                setInfoCardView()
                // 玩家此時可決定跳過進行下回合，電腦則等判斷完要不要買地產
                isCanNextRound = true
            }
            // 檢查是否要付過路費
            self.payToll(roleName: roleName)
        }
    }
    func payToll(roleName: String) {
        if let currentInfo = currentInfo {
            if roleName == "玩家", currentInfo.owner == "電腦" {
                playerStatus.money -= currentInfo.roadTollInfo[currentInfo.level]
                computerStatus.money += currentInfo.roadTollInfo[currentInfo.level]
            } else if  roleName == "電腦", currentInfo.owner == "玩家" {
                computerStatus.money -= currentInfo.roadTollInfo[currentInfo.level]
                playerStatus.money += currentInfo.roadTollInfo[currentInfo.level]
            }
        }
        setMoney()
        // 判斷是否有輸贏
        self.checkWinner()
    }
    func checkWinner() {
        // 判斷是否有人輸
        guard playerStatus.money < 0 || computerStatus.money < 0 else {
            return
        }
        var title: String = ""
        var message: String = ""
        if playerStatus.money < 0 {
            title = "你輸了QQ"
            message = "下次會更好..."
        } else if computerStatus.money < 0 {
            title = "你贏了！"
            message = "電腦覺得你很強"
        }
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "再來一局", style: .default) { (_) in
            self.dataInitialize()
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}
// end of view controller



// 設定棋子位置
func setChessPosition() {
    if let tileP = getSingleTileByIndex(playerStatus.currentPosition),
       let tileC = getSingleTileByIndex(computerStatus.currentPosition) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0.2, options: .curveEaseInOut) {
            chessPlayer.frame.origin = CGPoint(x: tileP.center.x, y: tileP.center.y - 50 + 8)
            chessComputer.frame.origin = CGPoint(x: tileC.center.x - 25, y: tileC.center.y - 50)
        }
    }
}

func getSingleTileByIndex(_ index: Int) -> SingleTileUIView? {
    if let tileUIViewG = tileUIViewG {
        let array = tileUIViewG.subviews.filter{ $0 is SingleTileUIView }
        return array.filter{ ($0 as! SingleTileUIView).tileIndex == index }[0] as? SingleTileUIView
    } else {
        return nil
    }
}

// 設定建築資訊卡片
func setInfoCardView() {
    if let card = infoCardG,
       let img = infoCardImgG,
       let owner = infoCardOwnerG,
       let toll = infoCardCurrentTollG,
       let nextToll = infoCardNextTollG,
       let title = infoCardBuildingTitleG,
       let buyBtn = infoCardBuyBtnG {
        if let currentInfo = currentInfo {
            print(currentInfo.level)
            print(currentInfo.roadTollInfo)
            print(currentInfo.roadTollInfo[currentInfo.level])
            img.image = UIImage(named: currentInfo.name)
            title.text = currentInfo.name
            owner.text = currentInfo.owner
            toll.text = String(currentInfo.roadTollInfo[currentInfo.level])
            if currentInfo.level >= 3 {
                nextToll.text = "已達最高等"
            } else {
                nextToll.text = String(currentInfo.roadTollInfo[currentInfo.level + 1])
            }
            
            // 如果玩家剛好在此格、建築未達最高等、玩家未行動、此格未屬於電腦。則顯示按鈕
            if currentInfo.index == playerStatus.currentPosition,
               currentInfo.level != 3,
               currentInfo.owner != "電腦",
               !playerStatus.actioned,
               currentRound == "玩家" {
                buyBtn.alpha = 1
                let cost = currentInfo.levelCostInfo[currentInfo.level]
                buyBtn.setTitle("$\(cost) 購買", for: .normal)
                // 錢不夠購買，按鈕 disabled
                if cost > playerStatus.money {
                    buyBtn.isEnabled = false
                }
            } else {
                buyBtn.alpha = 0
            }
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0.2, options: .curveEaseOut) {
                card.layer.opacity = 1
                card.frame.origin.x = 592
                if let tileUIViewG = tileUIViewG {
                    tileUIViewG.frame.origin.x = 100
                }
            }
        } else {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0.2, options: .curveEaseOut) {
                card.layer.opacity = 0
                card.frame.origin.x = 900
                if let tileUIViewG = tileUIViewG {
                    tileUIViewG.frame.origin.x = 191
                }
            }
        }
    }
}

// set money view
func setMoney() {
    if let playerMoneyG = playerMoneyG {
        playerMoneyG.text = "$\(playerStatus.money)"
    }
    if let computerMoneyG = computerMoneyG {
        computerMoneyG.text = "$\(computerStatus.money)"
    }
}


// single tile class
class SingleTileUIView: UIView {
    var tileIndex: Int?
    var tileImage: UIImageView?
    
    func customizeInit(index: Int) {
        self.setTileIndex(index)
        self.setTileImg()
        self.setInteractive()
    }
    
    private func setTileIndex(_ index: Int) {
        self.tileIndex = index
    }
    
    private func setInteractive() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.touchAction))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func touchAction(_ sender:UITapGestureRecognizer) {
        if let index = self.tileIndex, buildingInfoData[index] != nil {
            currentInfo = buildingInfoData[index]
        } else {
            currentInfo = nil
        }
        setInfoCardView()
    }
    
    func setTileImg() {
//        if let index = self.tileIndex, let buildingData = BuildingInfoData[index] {
//            
//        }
        self.tileImage = UIImageView()
        if let tileImage = self.tileImage {
            tileImage.image = UIImage(named: "tile")
            tileImage.frame = CGRect(x: 0, y: 0, width: 96, height: 54)
            tileImage.contentMode = .scaleAspectFit
            self.addSubview(tileImage)
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



// if let tileIndex = (tileUIView.subviews[0] as! SingleTileUIView).tileIndex {}
