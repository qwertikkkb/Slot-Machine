//
//  ContentView.swift
//  Slot Machine
//
//  Created by Nicolai Bodean on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry" ]
    
    @State private var highscore = 0
    @State private var coins = 100
    @State private var betAmmount = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView = false
    
     //Mark - Functions
    
    //Spin the reels
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
     }
    
    //Check the winning
    func checkWining() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            //Player wins
            playerWins()
            
            //New HighScore
            if coins > highscore {
                newHighScore()
            }
        } else {
            //Player Loses
            playerLoses()
        }
    }
    func playerWins() {
        coins +=  betAmmount * 10
    }
    
    func newHighScore() {
        highscore = coins
    }
    
    func playerLoses() {
        coins -= betAmmount
    }
    //Game is over
    
    
    var body: some View {
            ZStack {
                 //Mark - Background
                LinearGradient(gradient: Gradient(colors: [
                    Color("ColorPink"),
                    Color("ColorPurple")]),
                               startPoint: .top,
                               endPoint: .bottom).ignoresSafeArea(.all)
                
                
                 //Mark - Interface
                
                VStack(alignment: .center, spacing: 5) {
                     //Mark - Header
                   LogoView()
                  
            
              
                    
                     //Mark - Score
                    HStack {
                        HStack {
                            Text("Your\nCoins".uppercased())
                                .scoreLabelStyle()
                                .multilineTextAlignment(.trailing)
                            
                            Text("\(coins)")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                            
                        }
                        .modifier(ScoreContainerModifier())
                        
                        Spacer()
                        
                        HStack {
                            
                            Text("\(highscore)")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                            
                            Text("High\nScore".uppercased())
                                .scoreLabelStyle()
                                .multilineTextAlignment(.leading)
                            
                        }
                        .modifier(ScoreContainerModifier())
                    }
                    
                     //Mark - Slot machine
                    VStack(alignment: .center, spacing: 0) {
                         //Mark - REEL N1
                        ZStack {
                            ReelView()
                            Image(symbols[reels[0]])
                                .resizable()
                                .modifier(ImageModifier())
                             
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            //Mark - Reel N2
                            ZStack {
                                ReelView()
                                Image(symbols[reels[1]])
                                    .resizable()
                                    .modifier(ImageModifier())
                           
                            }
                            
                            Spacer()
                            //Mark - Reel N3
                            ZStack {
                                ReelView()
                                Image(symbols[reels[2]])
                                    .resizable()
                                    .modifier(ImageModifier())
                                  
                            }
                        }
                        .frame(maxWidth: 500)
                         //Mark - Spin Button
                        Button( action: {
                          //Spin the reels
                            self.spinReels()
                            
                            //Check winning
                            self.checkWining()
                
                        }) {
                            Image("gfx-spin")
                                .renderingMode(.original)
                                .resizable()
                                .modifier(ImageModifier())
                               
                        }
                       
                        
                        
                    } // Slot Machine
                    .layoutPriority(2)
                    
                     //Mark - Footer
                    
                    Spacer()
                    
                    HStack {
                         //Mark - BET 10
                        HStack(alignment: .center, spacing: 10) {
                            Image("gfx-casino-chips")
                                .resizable()
                                .opacity(0)
                                .modifier(CasinoChipsModifier())
                            
                            Button(action: {
                                //Do something
                            }, label: {
                                Text("10")
                                    .fontWeight(.heavy)
                                    .foregroundStyle(.yellow)
                                    .modifier(BetNumberModifier())
                                    .modifier(BetCapsuleModifire())
                                    
                            }
                                
                            )
                         
                        }
                        
                        //Mark - BET 20
                       HStack(alignment: .center, spacing: 10) {
                           Button(action: {
                               //Do something
                           }, label: {
                               Text("20")
                                   .fontWeight(.heavy)
                                   .foregroundStyle(.white)
                                   .modifier(BetNumberModifier())
                                   .modifier(BetCapsuleModifire())
                                   
                           }
                               
                           )
                           Image("gfx-casino-chips")
                               .resizable()
                               .opacity(1)
                               .modifier(CasinoChipsModifier())
                       }
                    }
                    
                }//VSTack
                .frame(height: 900)
                
                //Buttons
                .overlay(
                //Reset
                    Button(action: {
                        print("reset the game")
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath.circle")
                           
                    }
                    .modifier(ButtonModifier()),
                    alignment: .topLeading
                    
                )
                .overlay(
                //Info
                    Button(action: {
                        self.showingInfoView = true
                    }) {
                        Image(systemName: "info.circle")
                        
                          
                            
                            
                    }
                    .modifier(ButtonModifier()),
                    alignment: .topTrailing
                    
                )
                
                .padding()
                .frame(maxWidth: 720)
            }//ZStack
            .sheet(isPresented: $showingInfoView) {
                InfoView()
            }
            .frame(height: 900)
           
    }
}

#Preview {
    ContentView()
}
