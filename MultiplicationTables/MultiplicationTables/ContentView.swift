//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Matt Goodhart on 12/30/22.
//

import SwiftUI
//
//enum RoundPossibilities: Int, CaseIterable {
//    case fiveRounds = 5
//    case tenRounds = 10
//    case twentyRounds = 20
//}


struct Question {
    var multiplicant1 = 0
    var multiplicant2 = 0
    var questionText = ""
    var answer = 0
}

struct ContentView: View {
    
    @State private var isGameActive = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 1
    @State private var isGameOver = false
    @State private var roundsInGame = 5
    @State private var questionNumber = 0
    @State private var multiplicationTableChosen = 2
    @State private var userAnswer = ""
    @State private var questions: [Question] = []
    
    let roundPossibilities = [5, 10, 20]
    //var questions: [Question]
    var multiplicants: [Int] = [2,3,4,5,6,7,8,9,10,11,12].shuffled()
   // var questions: [Question] = []
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .cyan, .blue,], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text("Multiplication Times!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                Spacer()
                if !isGameActive {
                    Text("Choose your game settings")
                        .font(.largeTitle.weight(.regular))
                        .foregroundColor(.white)
                    
                    Stepper("What Multiplication Table Would You Like?", value: $multiplicationTableChosen, in: 2...12)
                    Text( "\(multiplicationTableChosen)").font(.title)
                        .foregroundColor(.white)
                    Spacer()
                    Text("How Many Questions Would You Like?")
                    Picker("How Many Questions?", selection: $roundsInGame) {
                        ForEach(roundPossibilities, id: \.self) { round in
                            Text(String(round))
                        }
                    }
                    .pickerStyle(.segmented)
                    Spacer()
                    Button {
                        generateQuestions()
                        resetGame()
                        isGameActive = true
                        questionNumber += 1
                        //askQuestion()
                    } label: {
                        Image(systemName: "play.fill")
                            .renderingMode(.original)
                            .foregroundColor(.white)
                    }
                    
                    
                    .alert(scoreTitle, isPresented: $showingScore) {
                        Button("Continue", action: askNextQuestion)
                    } message: {
                        Text("Your score is " + String(score))
                    }
                    .alert("Game Over. Your score total is \(score)", isPresented: $isGameOver) {
                        Button("New Game", action: resetGame)
                    } message: {
                        Text("Your score is " + String(score))
                    }
                } else {
                    Text(questions[questionNumber].questionText)
                        .font(.title.weight(.heavy))
                 
                 //   TextField("Enter Answer Here", value: $userAnswer, format: .number)
                    TextField("Enter Answer Here", text: $userAnswer )
                        .textInputAutocapitalization(.never)
                        .font(.callout.weight(.semibold))
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .onSubmit {
                            checkScore()
                        }
                    Spacer()
                    Text("Question \(questionNumber) of \(roundsInGame)")
                }
            }
        }
    }
    
    func checkScore() {
        
        guard let userAnswerInt = Int(userAnswer) else {
            return
        }
        
        if userAnswerInt == questions[questionNumber].answer {
            score += 1
        } else {
            score -= 1
        }
        showingScore.toggle()
    }
    
    func generateQuestions() {
        var questions: [Question] = []
        
        for round in 0..<roundsInGame {
            var question = Question()
            question.multiplicant1 = multiplicationTableChosen
            question.multiplicant2 = multiplicants[round]
            question.questionText = "What is \(question.multiplicant1) x \(question.multiplicant2)?"
            question.answer = question.multiplicant1 * question.multiplicant2
            questions.append(question)
        }
        self.questions = questions
    }
    
    func resetGame() {
        score = 0
        isGameOver = false
        isGameActive = false
        gameCount = 1
        roundsInGame = 5
        questionNumber = 0
        multiplicationTableChosen = 2
    }
    
    func askNextQuestion() {
        guard questionNumber != roundsInGame else {
            isGameOver = true
            return
        }
      //  answer = multiplicationTableChosen * (multiplicants.randomElement() ?? 0)
        questionNumber += 1
    }
    
    func incrementStepper() {
        guard roundsInGame != 20 else { return }
        roundsInGame *= 2
        
    }
    
    func decrementStepper() {
        guard roundsInGame != 5 else { return }
        roundsInGame /= 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
