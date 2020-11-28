//
//  ViewController.swift
//  monopoly-taiwan
//
//  Created by 郭家銘 on 2020/11/23.
//

import UIKit


class BuildingInfo {
    let index: Int
    let name: String
    let levelCostInfo: Array<Int>
    let roadTollInfo: Array<Int>
    var owner: String
    var level: Int
    let questions: Array<question>
    
    init(index: Int,
         name: String,
         levelCostInfo: Array<Int>,
         roadTollInfo: Array<Int>,
         owner: String,
         level: Int,
         questions: Array<question>) {
        self.index = index
        self.name = name
        self.levelCostInfo = levelCostInfo
        self.roadTollInfo = roadTollInfo
        self.owner = owner
        self.level = level
        self.questions = questions
    }
}
struct question {
    var title: String
    var options: Array<String>
    var answer: String
}
class PlayerStatus {
    let name: String
    var currentPosition: Int = 0
    var money: Int = 1000
    var actioned: Bool = false
    var answered: Bool = false
    
    init(name: String) {
        self.name = name
    }
}

let buildingInfoData: Array<BuildingInfo?> = [
    nil,
    BuildingInfo(index: 1 ,name: "赤崁樓", levelCostInfo: [200, 400, 900], roadTollInfo: [0, 100, 200, 500], owner: "無", level: 0,
                 questions: [
                    question(title: "赤崁樓的舊稱為？", options: ["普羅米修斯城", "普羅大眾城"], answer: "普羅民遮城"),
                    question(title: "赤崁樓前九座贔屭碑是為了紀念平定什麼事件而立？", options: ["戴潮春事件", "朱一貴事件"], answer: "林爽文事件"),
                    question(title: "身為台南人的小明，參觀赤崁樓的票價為？", options: ["50", "100"], answer: "免費"),
                 ]),
    BuildingInfo(index: 2, name: "林百貨", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "林百貨的俗稱為？", options: ["菊元百貨", "末廣町"], answer: "五層樓仔"),
                    question(title: "林百貨頂樓有什麼設施？", options: ["十字架", "佛壇"], answer: "神社"),
                    question(title: "「林」一字的日文發音為？", options: ["Kobayashi", "Lin"], answer: "Hayashi"),
                 ]),
    BuildingInfo(index: 3, name: "八五大樓", levelCostInfo: [300, 600, 1300], roadTollInfo: [0, 150, 300, 800], owner: "無", level: 0,
                 questions: [
                    question(title: "八五大樓的高度為？", options: ["508公尺", "828公尺"], answer: "378公尺"),
                    question(title: "八五大樓位於高雄哪個行政區？", options: ["新興區", "三民區"], answer: "苓雅區"),
                    question(title: "八五大樓建築外觀是以哪個漢字為概念設計？", options: ["「雄」", "甘"], answer: "高")
                 ]),
    BuildingInfo(index: 4, name: "合興車站", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "合興車站位於哪一縣市？", options: ["新竹市", "新北市"], answer: "新竹縣"),
                    question(title: "合興車站有一獨特的設計，請問這個設計是？", options: ["燕返式", "遞迴函式"], answer: "折返式"),
                    question(title: "合興車站原本是為了運輸什麼原料而設立的？", options: ["鋼鐵", "木頭"], answer: "水泥")
                 ]),
    BuildingInfo(index: 5, name: "國父紀念館", levelCostInfo: [200, 400, 900], roadTollInfo: [0, 100, 200, 500], owner: "無", level: 0,
                 questions: [
                    question(title: "國父紀念館是為了要紀念誰而設立的？", options: ["蔣中正", "蔣介石"], answer: "孫逸仙"),
                    question(title: "國父紀念館外觀是由哪兩種配色而成？", options: ["藍白", "紅綠"], answer: "黃紅"),
                    question(title: "國父紀念館之匾額，是誰題字的？", options: ["蔣經國", "蔣宋美齡"], answer: "蔣中正")
                 ]),
    BuildingInfo(index: 6, name: "安平古堡", levelCostInfo: [200, 400, 900], roadTollInfo: [0, 100, 200, 500], owner: "無", level: 0,
                 questions: [
                    question(title: "安平古堡的舊稱為？", options: ["紅毛城", "普羅民遮城"], answer: "熱蘭遮城"),
                    question(title: "下列哪個選項並非安平的特色？", options: ["劍獅", "蝦捲"], answer: "肉圓"),
                    question(title: "安平古堡內有哪位名人的雕像？", options: ["施琅", "陳永華"], answer: "鄭成功"),
                    question(title: "台南安平的舊稱為？", options: ["鹿耳門", "打狗"], answer: "大員"),
                 ]),
    BuildingInfo(index: 7, name: "巴比倫空中花園", levelCostInfo: [300, 600, 1300], roadTollInfo: [0, 150, 300, 800], owner: "無", level: 0,
                 questions: [
                    question(title: "下列哪個選項不是「古代世界七大奇蹟」？", options: ["巴比倫空中花園", "太陽神銅像"], answer: "黑帝斯神殿"),
                    question(title: "相傳巴比倫空中花園為哪個國王下令建造的？", options: ["尼可拉斯二世", "尼菩薩三世"], answer: "尼布甲尼撒二世"),
                    question(title: "相傳巴比倫空中花園於何時建造的？", options: ["西元六世紀", "西元十六世紀"], answer: "西元前六世紀")
                 ]),
    BuildingInfo(index: 8, name: "慶修院", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "慶修院的舊稱為？", options: ["般若波羅蜜布教所", "吉野家牛丼"], answer: "真言宗吉野布教所"),
                    question(title: "慶修院祭拜諸多神像，下咧哪個選項為其中一尊？", options: ["漢堡王像", "大阪王將"], answer: "不動明王像"),
                    question(title: "慶修院位於哪個縣市？", options: ["雲林縣", "苗栗縣"], answer: "花蓮縣")
                 ]),
    BuildingInfo(index: 9, name: "成大榕園", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "哪家企業以成大榕園作為其Logo標誌？", options: ["國泰航空", "台積電"], answer: "國泰人壽"),
                    question(title: "成大榕園旁的羅馬式建築，現為工設系館。請問在日治時期時是什麼用途？", options: ["監獄", "銀行"], answer: "兵舍"),
                    question(title: "哪件事不能在成大榕園做？", options: ["拍畢業照", "遛狗"], answer: "打樂樂棒球")
                 ]),
    BuildingInfo(index: 10, name: "新埔柿餅工廠", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "新埔地區有什麼加分的天然要素，讓柿餅成為當地特產？", options: ["龍捲風", "颱風"], answer: "九降風"),
                    question(title: "下列哪個程序並非古法製作柿餅的過程？", options: ["日曬風乾", "擠壓整形"], answer: "拋光打蠟"),
                    question(title: "哪個時期是柿餅產收季節？", options: ["鬼月", "二月到六月"], answer: "九月至一月")
                 ]),
    BuildingInfo(index: 11, name: "巨石陣", levelCostInfo: [200, 400, 900], roadTollInfo: [0, 100, 200, 500], owner: "無", level: 0,
                 questions: [
                    question(title: "巨石陣位於哪個國家？", options: ["智利", "美國"], answer: "英國"),
                    question(title: "下列選項哪個不是巨石陣的別稱？", options: ["索爾茲伯里石環", "斯通亨治石欄"], answer: "黃道石環"),
                 ]),
    BuildingInfo(index: 12, name: "成大牌坊", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "下列哪個選項不是成大校園的裝置藝術？", options: ["飛撲", "詩人"], answer: "咩噗"),
                    question(title: "成大牌坊上有四字，請問是？", options: ["「親愛精誠」", "「你各位啊」"], answer: "「窮理致知」"),
                    question(title: "成大校門口前有一條學生覓食的街道，名字是？", options: ["芝麻街", "撲街"], answer: "育樂街")
                 ]),
    BuildingInfo(index: 13, name: "黑帝斯神殿", levelCostInfo: [300, 600, 1300], roadTollInfo: [0, 150, 300, 800], owner: "無", level: 0,
                 questions: [
                    question(title: "黑帝斯為主宰何處的神？", options: ["月亮", "海洋"], answer: "冥界"),
                    question(title: "黑帝斯的父親為？", options: ["宙斯", "波賽頓"], answer: "克羅諾斯"),
                    question(title: "黑帝斯的形象旁通常會有一隻動物，看守冥界入口，這動物是？", options: ["地獄倒霉鬼", "地獄喵喵"], answer: "地獄三頭犬")
                 ]),
    BuildingInfo(index: 14, name: "教堂", levelCostInfo: [100, 200, 500], roadTollInfo: [0, 50, 100, 300], owner: "無", level: 0,
                 questions: [
                    question(title: "教堂的主要用途為？", options: ["躲貓貓", "睡覺"], answer: "敬拜神"),
                    question(title: "下列何者為位於台灣之教堂？", options: ["科隆大教堂", "光之教堂"], answer: "路思義教堂")
                 ]),
    BuildingInfo(index: 15, name: "中目黑星巴克", levelCostInfo: [200, 400, 900], roadTollInfo: [0, 100, 200, 500], owner: "無", level: 0,
                 questions: [
                    question(title: "中目黑星巴克位於哪個地區？", options: ["名古屋", "大阪"], answer: "東京"),
                    question(title: "星巴克的英文是？", options: ["Starfish", "StarWar"], answer: "Starbucks"),
                    question(title: "星巴克的發源地為？", options: ["水牛城", "矽谷"], answer: "西雅圖")
                 ])
]

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
        setQuestion()
        setAllTileTint()
    }
    
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
            setChessPosition()
            // 設定當前卡片
            currentInfo = buildingInfoData[role.currentPosition]
            if currentRound == "玩家" {
                setInfoCardView()
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
            label.textColor = UIColor(named: "IncorrectColor")
        } else {
            label.textColor = UIColor(named: "CorrectColor")
        }
        label.text = String(difference)
        
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
    
}
// end of view controller

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
                buyBtn.isEnabled = true
                buyBtn.alpha = 1
                let cost = currentInfo.levelCostInfo[currentInfo.level]
                buyBtn.setTitle("$\(cost) 購買", for: .normal)
                // 錢不夠購買，按鈕 disabled
                if cost > playerStatus.money || playerStatus.answered {
                    print(playerStatus.money)
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

// 設定金幣顯示
func setMoney() {
    if let playerMoneyG = playerMoneyG {
        playerMoneyG.text = "$\(playerStatus.money)"
    }
    if let computerMoneyG = computerMoneyG {
        computerMoneyG.text = "$\(computerStatus.money)"
    }
}

// 設定地盤顏色
func setAllTileTint() {
    if let tileUIViewG = tileUIViewG {
        let tileArray = tileUIViewG.subviews.filter{ $0 is SingleTileUIView }
        tileArray.forEach { tile in
            (tile as! SingleTileUIView).setTileImg()
        }
    }
}

// single tile class
class SingleTileUIView: UIView {
    var tileIndex: Int?
    var tileImage: UIImageView?
    
    func customizeInit(index: Int) {
        self.setTileIndex(index)
        self.tileImgInit()
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
    
    private func tileImgInit() {
        self.tileImage = UIImageView()
        if let tileImage = self.tileImage {
            tileImage.image = UIImage(named: "tile")
            tileImage.frame = CGRect(x: 0, y: 0, width: 96, height: 54)
            tileImage.contentMode = .scaleAspectFit
            self.addSubview(tileImage)
        }
    }
    
    func setTileImg() {
        if let index = self.tileIndex,
           let tileImage = self.tileImage,
           let building = buildingInfoData[index] {
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
