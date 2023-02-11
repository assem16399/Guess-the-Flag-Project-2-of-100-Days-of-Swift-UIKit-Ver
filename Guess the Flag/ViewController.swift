//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Aasem Hany on 09/10/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var countries = [String]()
    var userScore = 0
    var answerdQuestionsCounter = 0
    var correctAnswer: Int!
    var highScore = 0
    var prevHighScore:Int?
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        configureBarButton()
        
        askQuestion()
        getHighScoreFromUserDefaults()
    }
    
    
    func getHighScoreFromUserDefaults() {
        let defaults = UserDefaults.standard
        
        highScore = defaults.integer(forKey: "highScore")
        
    }
    private func configureBarButton(){
        let eyeImage = UIImage(systemName: "eye")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: eyeImage, style: .plain, target: self, action: #selector(onButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func onButtonTapped(){
        self.showToast(message: "Your Score is \(userScore)", font: .systemFont(ofSize: 18))
    }
    
    private func configureButtons(){
        configButtonsBorder()
        configButtonsBorderColor()
        configButtonsBorderPadding()
    }
    
    private func configButtonsBorder() {
        buttonOne.layer.borderWidth = 1.0
        buttonTwo.layer.borderWidth = 1.0
        buttonThree.layer.borderWidth = 1.0
    }
    
    private func configButtonsBorderColor() {
        buttonOne.layer.borderColor = UIColor.lightGray.cgColor
        buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
        buttonThree.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func configButtonsBorderPadding() {
        buttonOne.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        buttonTwo.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        buttonThree.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        resetButtonsAnimation()
        title = "\(answerdQuestionsCounter+1) - \(countries[correctAnswer].uppercased())"
    }
    
    func resetButtonsAnimation() {
        buttonOne.transform = .identity
        buttonTwo.transform = .identity
        buttonThree.transform = .identity
    }
    
    @IBAction func onAnswerSelected(_ sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        answerdQuestionsCounter += 1
        var title:String
        if sender.tag == correctAnswer {
            userScore += 1
            title = "Correct!"
            if userScore > highScore {
                updateHighScore()
            }
        }
        else {
            title = "Wrong!, This the Flag of \(countries[sender.tag].uppercased())"
        }
        showAlert(withTitle: title)
    }
    
    private func updateHighScore() {
        prevHighScore = highScore
        highScore = userScore
    }
    
    private func updateHighScoreInsideUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
    }
    private func showAlert(withTitle title:String){
        if answerdQuestionsCounter == 10 {
            showNewGameAlert(withTitle: title)
        }else{
            showNormalAlert(withTitle: title)
        }
    }
    
    
    private func showNewGameAlert(withTitle title:String){
        let ac:UIAlertController
        if let prevHighScore {
            let message = highScore>prevHighScore ? """
Congrats, you've achieved a new high score.
Your score is \(userScore) out if 10
""" : "Your score is \(userScore) out if 10"
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            updateHighScoreInsideUserDefaults()
        }else{
            ac = UIAlertController(title: title, message: "Your Score is \(userScore) out of 10", preferredStyle: .alert)
        }
        ac.addAction(UIAlertAction(title: "Play agin", style: .default){(_)in self.resetTheGame()})
        present(ac, animated: true)
    }
    
    private func showNormalAlert(withTitle title:String){
        let ac = UIAlertController(title: title, message: "Your Score is \(userScore)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default){(_)in self.askQuestion()})
        present(ac, animated: true)
    }
    
    private func resetTheGame(){
        self.answerdQuestionsCounter = 0
        self.userScore = 0
        self.askQuestion()
    }
    
}



extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }
