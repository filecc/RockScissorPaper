//
//  ContentView.swift
//  PaperScissorRock
//
//  Created by Filippo Giampapa on 07/04/2020.
//  Copyright © 2020 Filippo Giampapa. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var weapons = ["🏔", "✂️", "📄"]
    @State var shouldWin = false
    @State private var userChoice = true
    @State private var score = 0
    @State private var rectLenght : CGFloat = 1
    @State private var loops = 0
    @State private var userWeapon = "🏔"
    @State private var theEnd = false
    @State private var letsBegin = false
    @State private var backColor : Color = .gray
    @State private var title = "WIN"
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                if letsBegin {
                    Text("You should: \n\(title)").foregroundColor(.white).fontWeight(.black).font(.title)
                    Button (action: {
                    self.userWeapon = "🏔"
                    self.heChoice()
                }) {
                    gameImage(moves: "🏔")
                }
                }
                if letsBegin {
                Button (action: {
                    self.userWeapon = "✂️"
                    self.heChoice()
                }) {
                    gameImage(moves: "✂️")
                }
                }
                if letsBegin {
                Button (action: {
                    self.userWeapon = "📄"
                    self.heChoice()
                }) {
                    gameImage(moves: "📄")
                }
                }
                Spacer()
                Group {
                    if letsBegin {
                    Button (action: {
                        self.letsBegin.toggle()
                        self.score = 0
                        self.loops = -1
                        self.nextRound()
                        self.rectLenght = 1
                    }) {
                       Text("RESTART")
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    }.padding()
                    .frame(width: 140)
                    .foregroundColor(.green)
                    .background(Color.red)
                    .cornerRadius(40)
                    .overlay(Capsule().stroke(lineWidth: 2).foregroundColor(.white))
                    .shadow(radius: 4)
                    
                    } else {
                        Button (action: {
                            self.letsBegin.toggle()
                            self.nextRound()
                        }) {
                           Text("START")
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                           
                        }
                        .padding()
                        .frame(width: 140)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(40)
                        .overlay(Capsule().stroke(lineWidth: 2).foregroundColor(.white))
                        .shadow(radius: 4)
                        
                    }
                }
                HStack {
                    Rectangle()
                        .frame(width: rectLenght, height: 20)
                        .foregroundColor(.white)
                        .animation(.spring())
                    Spacer()
                }
                Spacer()
                
            }.alert(isPresented: self.$theEnd){
                Alert(title: Text("Finish."), message: Text("Your total score is: \(score)"), dismissButton: .destructive(Text("Ok")))
            }.background(backColor).edgesIgnoringSafeArea(.all).animation(.default)
        }
        
    }
    
    func colorBackground() {
        if shouldWin == true || shouldWin == false && loops <= 0 {
            withAnimation { backColor = .gray }
        }
        if shouldWin == true && loops != 0 {
            withAnimation { backColor = .green }
        } else if shouldWin == false && loops != 0 {
            withAnimation { backColor = .red }
        }
    
    }
    func nextRound() {
        shouldWin = Bool.random()
        loops += 1
        withAnimation {
        rectLenght = rectLenght + 40
        colorBackground()
            switch shouldWin {
            case true:
                title = "WIN"
            case false:
                title = "LOSE"
            }
        }
        if loops == 10 {
            theEnd.toggle()
            backColor = .gray
            letsBegin.toggle()
            loops = 0
            rectLenght = 1
        }
    }
    
    
    func heChoice ()  {
        let appWeapon = weapons[Int.random(in: 0...2)]
        colorBackground()
        
        if appWeapon == "🏔" && shouldWin == true {
                switch userWeapon {
                case "📄":
                    score += 1
                case "🏔":
                    score += 0
                default:
                    score -= 1
                }
            nextRound()
        } else if appWeapon == "🏔" && shouldWin == false {
                switch userWeapon {
                case "✂️":
                    score += 1
                case "🏔":
                    score += 0
                default:
                    score -= 1
                }
            nextRound()
        }
        
        if appWeapon == "✂️" && shouldWin == true {
                switch userWeapon {
                case "🏔":
                    score += 1
                case "✂️":
                    score += 0
                default:
                    score -= 1
                }
            nextRound()
        } else if appWeapon == "✂️" && shouldWin == false {
                switch userWeapon {
                case "📄":
                    score += 1
                case "✂️":
                    score += 0
                default:
                    score += 0
                }
            nextRound()
        }
        
        if appWeapon == "📄" && shouldWin == true {
                switch userWeapon {
                case "✂️":
                    score += 1
                case "📄":
                    score += 0
                default:
                    score -= 1
                }
            nextRound()
        } else if appWeapon == "📄" && shouldWin == false {
                switch userWeapon {
                case "🏔":
                    score += 1
                case "📄":
                    score += 0
                default:
                    score += 0
                }
            nextRound()
        }
    }
    
}


struct gameImage : View {
    
    let moves : String
    var body: some View {
        VStack {
            
                Capsule()
                .foregroundColor(.white)
                .overlay(Text(moves))
                .font(.largeTitle)
                .frame(width: 150, height: 100)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 3).shadow(radius: 2))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
