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
    var correctAnswer: Int!
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()

        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        selectFlags()
        

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
    
    private func selectFlags() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }


}

