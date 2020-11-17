//
//  ContentView.swift
//  GuessTheCountry
//
//  Created by Alisultan Abdullah on 14.11.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["UK", "USA", "Bangladesh", "Germany", "Germany", "Argentina", "Brazil", "Canada", "Greece", "Russia", "Sweeden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore  = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 60) {
                VStack {
                    Text("Choose the flag: ")
                        .foregroundColor(.pink)
                        .font(.title)
                    Text(countries[correctAnswer])
                        .foregroundColor(.pink)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) {number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .frame(width: 250, height: 130)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.pink, lineWidth: 2))
                            .shadow(color: .pink, radius: 2)
                    }
                }
                Text("General score: \(score)")
                    .foregroundColor(.pink)
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
        }         .alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text("General score \(score)"),
                          dismissButton: .default(Text("Continue")){
                            self.askQuestion()
                          })
                }
        }
        
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    
        func flagTapped(_ number: Int) {
            if number == correctAnswer {
                scoreTitle = "Correct answer!"
                score += 1
            } else {
                scoreTitle = "Incorrect! This flag is \(countries[number])"
                score -= 1
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
