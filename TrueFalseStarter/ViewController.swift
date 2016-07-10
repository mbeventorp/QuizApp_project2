//
//  ViewController.swift
//  TrueFalseStarter
//
//  Orginally Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
// //Mikael Beventorp


import UIKit
import GameKit


class ViewController: UIViewController {
    
    
    let questionsPerRound = allQuestions.count
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var previousQuestionsArray: [Int] = []
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start game
       
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func displayQuestion() {
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(allQuestions.count)
        
        // while loop for making sure that questions are not repeated
        while previousQuestionsArray.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(allQuestions.count)
        }
        
        
        previousQuestionsArray.append(indexOfSelectedQuestion)
        
        let gameQuestions = allQuestions[indexOfSelectedQuestion]
        questionField.text = gameQuestions.question
        playAgainButton.hidden = true
        
        
        enableButtons()
        
        // choices for every question
        
        firstChoiceButton.setTitle(gameQuestions.option1, forState: .Normal)
        secondChoiceButton.setTitle(gameQuestions.option2, forState: .Normal)
        thirdChoiceButton.setTitle(gameQuestions.option3, forState: .Normal)
        fourthChoiceButton.setTitle(gameQuestions.option4, forState: .Normal)
        
       
    }
    
    func displayScore() {
        // Hide the answer buttons
        firstChoiceButton.hidden = true
        secondChoiceButton.hidden = true
        thirdChoiceButton.hidden = true
        fourthChoiceButton.hidden = true
        
        
        // Display play again button
        playAgainButton.hidden = false
        
        if correctQuestions == questionsAsked {
            questionField.text = "Solid work dude!You got \(correctQuestions) out of \(questionsPerRound) correct!"
            
        } else if correctQuestions >= 5 && correctQuestions < 10 {
            questionField.text = "Nice job, you did pretty good! \(correctQuestions) out of \(questionsPerRound)"
            
            
        } else {
            questionField.text = "Sorry! Try Again? \(correctQuestions) out of \(questionsPerRound)"
                    }

    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = allQuestions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.answer
        
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            disableButtons()
            
        } else {
            questionField.text = "Sorry, wrong answer! \n\n Correct Answer: \(correctAnswer)"
            
            disableButtons()
            
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
                    } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        firstChoiceButton.hidden = false
        secondChoiceButton.hidden = false
        thirdChoiceButton.hidden = false
        fourthChoiceButton.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        previousQuestionsArray.removeAll()
        
        nextRound()
        
    }
    
   
    
    
    
   
    
    // MARK: Helper Methods
    
    // Helper Method to enable and disable the buttons after user has answered a question
    
    func enableButtons() {
        
        firstChoiceButton.userInteractionEnabled = true
        secondChoiceButton.userInteractionEnabled = true
        thirdChoiceButton.userInteractionEnabled = true
        fourthChoiceButton.userInteractionEnabled = true
        
    }
    
    func disableButtons() {
        
        firstChoiceButton.userInteractionEnabled = false
        secondChoiceButton.userInteractionEnabled = false
        thirdChoiceButton.userInteractionEnabled = false
        fourthChoiceButton.userInteractionEnabled = false
        
    }
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
        
    }
    
    }

