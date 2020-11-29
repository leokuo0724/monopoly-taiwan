//
//  ViewController.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/23.
//

import UIKit

var buildingInfoData: Array<BuildingInfo?> = [nil]

var currentInfo: BuildingInfo?
var currentQuestionIndex: Int = 0
// 擲骰 -> 玩家 -> 電腦
var currentRound: String = "擲骰"
var isCanNextRound: Bool = true
var isQnA: Bool = false

var playerStatus = PlayerStatus(name: "玩家")
var computerStatus = PlayerStatus(name: "電腦")

let chessPlayer = UIImageView()
let chessComputer = UIImageView()

//var tileUIViewG: UIView?
//var infoCardG: UIView?
//var playerMoneyG: UILabel?
//var computerMoneyG: UILabel?
//var infoCardImgG: UIImageView?
//var infoCardOwnerG: UILabel?
//var infoCardCurrentTollG: UILabel?
//var infoCardNextTollG: UILabel?
//var infoCardBuildingTitleG: UILabel?
//var infoCardBuyBtnG: UIButton?

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
    @IBOutlet weak var questionRootView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionBtn0: UIButton!
    @IBOutlet weak var optionBtn1: UIButton!
    @IBOutlet weak var optionBtn2: UIButton!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var playerMoneyChangeLabel: UILabel!
    @IBOutlet weak var computerMoneyChangeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 載入 json 到 buildingInfoData
        self.loadBuildingInfoJsonInit()
        
        // 背景樣式初始化
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [CGColor(srgbRed: 198/255, green: 255/255, blue: 221/255, alpha: 1), CGColor(srgbRed: 251/255, green: 215/255, blue: 134/255, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // 卡片樣式初始化
        self.infoCardInit()
        
        // 地板格子初始化
        self.tileInit()
        
        // 問題題目初始化
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        setDisplayQuestion()
        
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
        
        // 問題選項樣式初始化
        setOptionBtnsStyle(buttons: [optionBtn0,optionBtn1,optionBtn2])

        // 資料整體初始化
        dataInitialize()
    }
    
    // 資料整體初始化
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
    // view 整體初始化
    func viewInitialize() {
        setMoney()
        setChessPosition()
        setRoundView()
        setInfoCardView()
        setQuestion()
        setAllTileTint()
    }
    
    // json 資料輸入
    func loadBuildingInfoJsonInit() {
        do {
            let url = Bundle.main.url(forResource: "buildingInfoData", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([BuildingInfoData].self, from: data)
            
            // json 資料裝載
            for building in result {
                buildingInfoData.append(BuildingInfo(
                    index: building.index, name: building.name, levelCostInfo: building.levelCostInfo, roadTollInfo: building.roadTollInfo, owner: "無", level: 0, questions: building.questions
                ))
            }
        } catch {
            print(error)
        }
    }
    
    // 地板格子初始化
    func tileInit() {
        for i in 0..<buildingInfoData.count {
            let centerHorizon = tileUIView.center.y
            
            var frame = CGRect()
            var zIndex: Int = 0
            if i <= 4 {
                frame = CGRect(x: centerHorizon - CGFloat(48 * i), y: CGFloat(24 * (i + 1)), width: 96, height: 54)
                zIndex = i
            } else if i > 4, i <= 8 {
                frame = CGRect(x: centerHorizon + CGFloat(48 * (i - 8)), y: CGFloat(24 * (i + 1)), width: 96, height: 54)
                zIndex = i
            } else if i > 8, i <= 12 {
                frame = CGRect(x: centerHorizon + CGFloat(48 * (i - 8)), y: CGFloat(24 * (-i + 17)), width: 96, height: 54)
                zIndex = 16-i
            } else if i > 12, i <= 15 {
                frame = CGRect(x: centerHorizon + CGFloat(48 * (-i + 16)), y: CGFloat(24 * (-i + 17)), width: 96, height: 54)
                zIndex = 16-i
            }
            
            let singleTile = SingleTileUIView(frame: frame, tileIndex: i, touchFunc: self.setInfoCardView)
            if let name = buildingInfoData[i]?.name {
                singleTile?.setBuildingImg(name: name)
            }
            tileUIView.insertSubview(singleTile!, at: zIndex)
        }
    }
    
    // 建築資訊卡片樣式初始化
    func infoCardInit() {
        infoCard.layer.cornerRadius = 12
        infoCard.layer.shadowColor = UIColor.black.cgColor
        infoCard.layer.shadowOpacity = 0.3
        infoCard.layer.shadowRadius = 10
        infoCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        infoCardUpperView.clipsToBounds = true
        infoCardUpperView.layer.cornerRadius = 12
        infoCardUpperView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = infoCardUpperView.frame
        gradientLayer.colors = [CGColor(srgbRed: 251/255, green: 215/255, blue: 134/255, alpha: 1), CGColor(srgbRed: 240/255, green: 136/255, blue: 125/255, alpha: 1)]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        infoCardUpperView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // 關閉建築資訊卡片
    @IBAction func closeInfoCard(_ sender: Any) {
        currentInfo = nil
        setInfoCardView()
    }
    
    // 購買建築
    @IBAction func buyBuilding(_ sender: Any) {
        // 進入回答問題
        isQnA = true
        setDisplayQuestion()
    }
    func purchase() {
        if currentRound == "玩家", currentInfo!.owner != "電腦" {
            // 初次購買
            if currentInfo!.owner == "無" {
                currentInfo!.owner = currentRound
            }
            playerStatus.money -= currentInfo!.levelCostInfo[currentInfo!.level]
            self.showMoneyChangeLabel(label: playerMoneyChangeLabel, difference: -currentInfo!.levelCostInfo[currentInfo!.level])
            currentInfo!.level += 1
            playerStatus.actioned = true
            getSingleTileByIndex(playerStatus.currentPosition)?.setTileImg()
            setMoney()
        } else if currentRound == "電腦", currentInfo!.owner != "玩家" {
            // 初次購買
            if currentInfo!.owner == "無" {
                currentInfo!.owner = currentRound
            }
            computerStatus.money -= currentInfo!.levelCostInfo[currentInfo!.level]
            self.showMoneyChangeLabel(label: computerMoneyChangeLabel, difference: -currentInfo!.levelCostInfo[currentInfo!.level])
            currentInfo!.level += 1
            computerStatus.actioned = true
            getSingleTileByIndex(computerStatus.currentPosition)?.setTileImg()
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
        role.answered = false
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
            self.setChessPosition()
            // 設定當前卡片
            currentInfo = buildingInfoData[role.currentPosition]
            if currentRound == "玩家" {
                self.setInfoCardView()
                self.setQuestion()
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
                self.showMoneyChangeLabel(label: playerMoneyChangeLabel, difference: -currentInfo.roadTollInfo[currentInfo.level])
                computerStatus.money += currentInfo.roadTollInfo[currentInfo.level]
                self.showMoneyChangeLabel(label: computerMoneyChangeLabel, difference: currentInfo.roadTollInfo[currentInfo.level])
            } else if  roleName == "電腦", currentInfo.owner == "玩家" {
                computerStatus.money -= currentInfo.roadTollInfo[currentInfo.level]
                self.showMoneyChangeLabel(label: computerMoneyChangeLabel, difference: -currentInfo.roadTollInfo[currentInfo.level])
                playerStatus.money += currentInfo.roadTollInfo[currentInfo.level]
                self.showMoneyChangeLabel(label: playerMoneyChangeLabel, difference: currentInfo.roadTollInfo[currentInfo.level])
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
    
    // 重新開始遊戲
    @IBAction func forceReset(_ sender: Any) {
        let controller = UIAlertController(title: "是否要重新開局？", message: "電腦：投降輸一半？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: nil)
        controller.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "重新一局", style: .default) { (_) in
            self.dataInitialize()
        }
        controller.addAction(confirmAction)
        present(controller, animated: true, completion: nil)
    }
    
    // 點擊答案選項
    @IBAction func selectOption(_ sender: UIButton) {
        if let text = sender.titleLabel?.text,
           let currentInfo = currentInfo {
            let answer = currentInfo.questions[currentQuestionIndex].answer
            // 答案是否吻合
            if (text == answer) {
                self.purchase()
                setInfoCardView()
                self.showNotification(isCorrect: true)
            } else {
                self.showNotification(isCorrect: false)
            }
            isQnA = false
            playerStatus.answered = true
            setDisplayQuestion()
            setInfoCardView()
        }
    }
    
    // 設定問題與題目
    func setQuestion() {
        if let currentInfo = currentInfo {
            let index = Int.random(in: 0...currentInfo.questions.count - 1)
            // 設定題目索引
            currentQuestionIndex = index
            let selectedQ =  currentInfo.questions[index]
            // 設定題目
            questionLabel.text = selectedQ.title
            
            var optionsArr: Array<String> = []
            optionsArr.append(contentsOf: selectedQ.options)
            optionsArr.append(selectedQ.answer)
            optionsArr.shuffle()
            
            // 設定問題
            optionBtn0.setTitle(optionsArr[0], for: .normal)
            optionBtn1.setTitle(optionsArr[1], for: .normal)
            optionBtn2.setTitle(optionsArr[2], for: .normal)
        } else {
            questionLabel.text = ""
            optionBtn0.setTitle("", for: .normal)
            optionBtn1.setTitle("", for: .normal)
            optionBtn2.setTitle("", for: .normal)
        }
    }
    // 設定問題是否出現
    func setDisplayQuestion() {
        // 要先解除隱藏才有動畫
        if isQnA { questionRootView.isHidden = false }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0) {
            if isQnA {
                self.questionRootView.alpha = 1
            } else {
                self.questionRootView.alpha = 0
            }
        } completion: { (_) in
            self.questionRootView.isHidden = !isQnA
        }

    }
    // 設定答案正確與否提示
    func showNotification(isCorrect: Bool) {
        let label = notificationView.subviews.filter({ $0 is UILabel })[0]
        let image = notificationView.subviews.filter({ $0 is UIImageView })[0]

        if isCorrect {
            (label as! UILabel).text = "答案正確，購買成功！"
            (label as! UILabel).textColor = UIColor(named: "CorrectColor")
            (image as! UIImageView).image = UIImage(named: "correct")
        } else {
            (label as! UILabel).text = "答案錯誤，購買失敗！"
            (label as! UILabel).textColor = UIColor(named: "IncorrectColor")
            (image as! UIImageView).image = UIImage(named: "incorrect")
        }
        
        // 動畫
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
            self.notificationView.frame.origin.y = 342
        } completion: { (_) in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6, delay: 0.8, options: .curveEaseOut) {
                self.notificationView.frame.origin.y = 420
            }
        }
    }
    
    // 顯示金錢變化
    func showMoneyChangeLabel(label: UILabel, difference :Int) {
        if difference < 0 {
            label.text = "-$\(-difference)"
            label.textColor = UIColor(named: "IncorrectColor")
        } else {
            label.text = "+$\(difference)"
            label.textColor = UIColor(named: "CorrectColor")
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            label.alpha = 1
            if label == self.playerMoneyChangeLabel {
                label.frame.origin.y = 23
            } else if label == self.computerMoneyChangeLabel {
                label.frame.origin.y = 98
            }
        } completion: { (_) in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.8, delay: 0.8, options: .curveEaseOut) {
                label.alpha = 0
            } completion: { (_) in
                if label == self.playerMoneyChangeLabel {
                    label.frame.origin.y = 44
                } else if label == self.computerMoneyChangeLabel {
                    label.frame.origin.y = 119
                }
            }
        }
    }
    
    // 設定答案樣式
    func setOptionBtnsStyle(buttons: Array<UIButton>) {
        for btn in buttons {
            btn.layer.borderWidth = 1
            btn.layer.borderColor = CGColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
            btn.layer.cornerRadius = btn.frame.height/2
        }
    }

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
        let array = tileUIView.subviews.filter{ $0 is SingleTileUIView }
        return array.filter{ ($0 as! SingleTileUIView).tileIndex == index }[0] as? SingleTileUIView
    }

    // 設定建築資訊卡片
    func setInfoCardView() {
        if let currentInfo = currentInfo {
            infoCardImg.image = UIImage(named: currentInfo.name)
            infoCardBuildingTitle.text = currentInfo.name
            infoCardOwner.text = currentInfo.owner
            infoCardCurrentToll.text = String(currentInfo.roadTollInfo[currentInfo.level])
            if currentInfo.level >= 3 {
                infoCardNextToll.text = "已達最高等"
            } else {
                infoCardNextToll.text = String(currentInfo.roadTollInfo[currentInfo.level + 1])
            }
            
            // 如果玩家剛好在此格、建築未達最高等、玩家未行動、此格未屬於電腦。則顯示按鈕
            if currentInfo.index == playerStatus.currentPosition,
               currentInfo.level != 3,
               currentInfo.owner != "電腦",
               !playerStatus.actioned,
               currentRound == "玩家" {
                infoCardBuyBtn.isEnabled = true
                infoCardBuyBtn.alpha = 1
                let cost = currentInfo.levelCostInfo[currentInfo.level]
                infoCardBuyBtn.setTitle("$\(cost) 購買", for: .normal)
                // 錢不夠購買，按鈕 disabled
                if cost > playerStatus.money || playerStatus.answered {
                    print(playerStatus.money)
                    infoCardBuyBtn.isEnabled = false
                }
            } else {
                infoCardBuyBtn.alpha = 0
            }
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0.2, options: .curveEaseOut) {
                self.infoCard.layer.opacity = 1
                self.infoCard.frame.origin.x = 592
                self.tileUIView.frame.origin.x = 100
            }
        } else {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4, delay: 0.2, options: .curveEaseOut) {
                self.infoCard.layer.opacity = 0
                self.infoCard.frame.origin.x = 900
                self.tileUIView.frame.origin.x = 191
            }
        }
        
    }

    // 設定金幣顯示
    func setMoney() {
        playerMoney.text = "$\(playerStatus.money)"
        computerMoney.text = "$\(computerStatus.money)"
    }

    // 設定地盤顏色
    func setAllTileTint() {
        let tileArray = tileUIView.subviews.filter{ $0 is SingleTileUIView }
        tileArray.forEach { tile in
            (tile as! SingleTileUIView).setTileImg()
        }
    }
    
}


