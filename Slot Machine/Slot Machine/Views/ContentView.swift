//
//  ContentView.swift
//  Slot Machine
//
//  Created by Nicolai Bodean on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    
    let symbols = ["gfx-bell", 
                   "gfx-cherry",
                   "gfx-coin",
                   "gfx-grape",
                   "gfx-seven",
                   "gfx-strawberry" ]
    
    let haptics = UINotificationFeedbackGenerator()
    
    @State private var highscore = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins = 100
    @State private var betAmmount = 10
    @State private var reels: Array = [0, 1, 2]
    @State private var showingInfoView = false
    @State private var isActiveBet10 = true
    @State private var isActiveBet20 = false
    @State private var showingModel = false
    @State private var animatingSymbol = false
    @State private var animatingModel = false
    
     //Mark - Functions
    
    //Spin the reels
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
     }
    
    //Check the winning
    func checkWining() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            //Player wins
            playerWins()
            
            //New HighScore
            if coins > highscore {
                newHighScore()
            } else {
                playSound(sound: "win", type: "mp3")
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
        UserDefaults.standard.set(highscore, forKey: "HoghScore")
        playSound(sound: "high-score", type: "mp3")
    }
    
    func playerLoses() {
        coins -= betAmmount
    }
    
    func activateBet20() {
        betAmmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    func activateBet10() {
        betAmmount = 10
       isActiveBet10 = true
       isActiveBet20 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    //Game is over
    func isGameOver() {
        if coins <= 0 {
            showingModel = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeup", type: "mp3")
    }
    
    
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
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                    playSound(sound: "riseup", type: "mp3")
                                })
                             
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            //Mark - Reel N2
                            ZStack {
                                ReelView()
                                Image(symbols[reels[1]])
                                    .resizable()
                                    .modifier(ImageModifier())
                                    .opacity(animatingSymbol ? 1 : 0)
                                    .offset(y: animatingSymbol ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                    .onAppear(perform: {
                                        self.animatingSymbol.toggle()
                                    })
                           
                            }
                            
                            Spacer()
                            //Mark - Reel N3
                            ZStack {
                                ReelView()
                                Image(symbols[reels[2]])
                                    .resizable()
                                    .modifier(ImageModifier())
                                    .opacity(animatingSymbol ? 1 : 0)
                                    .offset(y: animatingSymbol ? 0 : -50)
                                    .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                    .onAppear(perform: {
                                        self.animatingSymbol.toggle()
                                    })
                                  
                            }
                        }
                        .frame(maxWidth: 500)
                         //Mark - Spin Button
                        Button( action: {
                            // 1. Set the default state: No animation
                            withAnimation {
                                self.animatingSymbol = false
                            }
                            
                          // 2. Spin the reels with changing the symbols
                            self.spinReels()
                            
                            // 3. Trigger the animation after changing the symbols
                            withAnimation {
                                self.animatingSymbol = true
                            }
                            
                            // 4. Check winning
                            self.checkWining()
                            
                            // 5. Game is over
                            self.isGameOver()
                
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
                                .offset(x: isActiveBet10 ? 0 : -20)
                                .opacity(isActiveBet10 ? 1 : 0)
                                .modifier(CasinoChipsModifier())
                            
                            Button(action: {
                                self.activateBet10()
                            }, label: {
                                Text("10")
                                    .fontWeight(.heavy)
                                    .foregroundStyle(isActiveBet10 ? Color("ColorYellow") : Color.white)
                                    .modifier(BetNumberModifier())
                                    .modifier(BetCapsuleModifire())
                                    
                            }
                                
                            )
                         
                        }
                        
                        //Mark - BET 20
                       HStack(alignment: .center, spacing: 10) {
                           Button(action: {
                               self.activateBet20()
                           }, label: {
                               Text("20")
                                   .fontWeight(.heavy)
                                   .foregroundStyle(isActiveBet20 ? Color("ColorYellow") : Color.white)
                                   .modifier(BetNumberModifier())
                                   .modifier(BetCapsuleModifire())
                                   
                           }
                               
                           )
                           Image("gfx-casino-chips")
                               .resizable()
                               .offset(x: isActiveBet20 ? 0 : 20)
                               .opacity(isActiveBet20 ? 1 : 0)
                               .modifier(CasinoChipsModifier())
                       }
                    }
                    
                }//VSTack
                .frame(height: 900)
                
                //Buttons
                .overlay(
                //Reset
                    Button(action: {
                        self.resetGame()
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
                .blur(radius: $showingModel.wrappedValue ? 5 : 0, opaque: false)
                
                 //Mark - POPUP
                if $showingModel.wrappedValue {
                    ZStack {
                        Color("ColorTransparentBlack").ignoresSafeArea(edges: .all)
                        
                        //Model
                        VStack(spacing: 0) {
                            //Title
                            Text("GAME OVER")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.heavy)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color("ColorPink"))
                                .foregroundStyle(Color.white)
                            
                            Spacer()
                            
                            //Message
                            VStack(alignment: .center, spacing: 16) {
                                Image("gfx-seven-reel")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 72)
                                
                                Text("Bad Luck! You lost all of the coins. \nLet's play again!")
                                    .font(.system(.body, design: .rounded))
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(Color.gray)
                                    .layoutPriority(1)
                                
                                Button(action: {
                                    self.showingModel = false
                                    self.animatingModel = false
                                    self.activateBet10()
                                    self.coins = 100
                                }) {
                                    Text("New Game".uppercased())
                                        .font(.system(.body, design: .rounded))
                                        .fontWeight(.semibold)
                                        .accentColor(Color("ColorPink"))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .frame(minWidth: 128)
                                        .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundStyle(Color("ColorPink"))
                                        )
                                }
                            }
                            
                            Spacer()
                            
                        }
                        .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                        .opacity($animatingModel.wrappedValue ? 1 : 0)
                        .offset(y: $animatingModel.wrappedValue ? 0 : -100)
                        .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                        .onAppear(perform: {
                            self.animatingModel = true
                        })
                    }
                }
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
