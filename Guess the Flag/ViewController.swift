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
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        askQuestion()
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
        title = "\(answerdQuestionsCounter+1) - \(countries[correctAnswer].uppercased())"
    }

    @IBAction func onAnswerSelected(_ sender: UIButton) {
        answerdQuestionsCounter += 1
        var title:String
        if sender.tag == correctAnswer {
            userScore += 1
            title = "Correct!"
        }
        else {
            title = "Wrong!, This the Flag of \(countries[sender.tag].uppercased())"
        }
        showAlert(withTitle: title)
    }
    
    private func showAlert(withTitle title:String){
        if answerdQuestionsCounter == 10 {
            showNewGameAlert(withTitle: title)
        }else{
            showNormalAlert(withTitle: title)
        }
    }
    
    
    private func showNewGameAlert(withTitle title:String){
        let ac = UIAlertController(title: title, message: "Your Score is \(userScore) out of 10", preferredStyle: .alert)
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

