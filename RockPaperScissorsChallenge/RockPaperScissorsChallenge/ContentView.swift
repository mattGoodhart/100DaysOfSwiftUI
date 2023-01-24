//
//  ContentView.swift
//  RockPaperScissorsChallenge
//
//  Created by Matt Goodhart on 12/15/22.
//

import SwiftUI

struct ContentView: View {
    
   
   // @State private var userChoice: String = ""
    @State private var computerChoice: Int = 0
    @State private var shouldUserWin: Bool = true
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var shouldShowScore = false
    @State private var gameCount = 1
    @State private var gameShouldEnd = false
    
    @State private var choices: [String] = ["Rock 🪨", "Paper 📄", "Scissors✂️"]
    var winningMoves: [String] = ["Paper 📄", "Scissors✂️", "Rock 🪨"]
    
    
    
    var body: some View {
        VStack {
            Text("Your score is " + String(score))
                .font(.largeTitle.weight(.semibold))
            Spacer(minLength: 20)
            Text("Round " + String(gameCount))
            Text("Computer chooses " + choices[computerChoice])
                .fontWeight(.semibold)
            Spacer()
            Text(shouldUserWin ? "You need to WIN this round" : "You need to LOSE this round" )
                .font(.title)
                Spacer()
            Text("Your Choice:")
            
            ForEach(0..<3) { choiceNumber in
                Button {
                    userChooses(choiceNumber)
                } label: {
                    Text(choices[choiceNumber])
                }
                .padding()
            }
            Spacer()
        }
        .padding()
        .alert(scoreTitle, isPresented: $shouldShowScore) {
            Button("Next Round", action: newRound)
        } message:{
            Text("Your score is " + String(score))
        }
        .alert("Game Over. Your score total is ", isPresented: $gameShouldEnd) {
            Button("New Game", action: resetGame)
        } message: {
            Text("Your score is " + String(score))
                }
        }
  
    func userChooses(_ choiceNumber: Int) {
       // let userChoice = choices[choiceNumber]
        if (winningMoves[computerChoice] == choices[choiceNumber] && shouldUserWin) ||  (winningMoves[computerChoice] != choices[choiceNumber] && !shouldUserWin) {
            score += 1
            scoreTitle = "You got it right!"
        } else {
            scoreTitle = "You are a fucking idiot."
            score -= 1
        }
        shouldShowScore = true
      
    }
    
    func newRound() {
        if gameCount == 9 {
            gameShouldEnd = true
        }
//        if gameCount == 1 {
//            resetGame()
//        }
        gameCount += 1
        shouldShowScore = false
        computerMakeMove()
    }
    
    func computerMakeMove() {
        //choices.shuffle()
        computerChoice = Int.random(in: 0...2)
        shouldUserWin = Bool.random()
        
    }
    
    func resetGame() {
        score = 0
        gameCount = 0
        computerMakeMove()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
