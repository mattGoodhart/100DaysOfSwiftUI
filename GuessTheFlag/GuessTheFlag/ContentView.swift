//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matt Goodhart on 12/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var gameCount = 1
    @State private var isGameOver = false
    @State private var flagPicked = 4
    @State private var wasFlagPicked = false
    
    struct FlagImage: ViewModifier {
        var image: String
        
        func body(content: Content) -> some View {
            content
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
                
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            flagPicked = number
                            withAnimation {
                                wasFlagPicked = true
                            }
                        } label: {
                            if flagPicked != number {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                                    .opacity(wasFlagPicked ? 0.25 : 1)
                                    .scaleEffect(wasFlagPicked ? 0.5 : 1, anchor: .center)
                            } else {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                                    .rotation3DEffect(wasFlagPicked ? .degrees(Double(360)) : .zero, axis: (x: 0, y: 1, z: 0))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: " + String(score))
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is " + String(score))
            }
            .alert("Game Over. Your score total is ", isPresented: $isGameOver) {
                Button("New Game", action: resetGame)
            } message: {
                Text("Your score is " + String(score))
            }
        }
    }
        
    func flagTapped(_ number: Int) {
      
        if number == correctAnswer {
            
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that was the flag of " + countries[number] + " you clown"
            score -= 1
        }
    
        showingScore = true
        }
    
    func askQuestion() {
        
        guard gameCount != 8 else {
            isGameOver = true
            return
        }
        
        wasFlagPicked = false
        
        gameCount += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        gameCount = 0
        score = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
