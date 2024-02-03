//
//  ContentView.swift
//  Slot Machine
//
//  Created by Nicolai Bodean on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showingInfoView = false
    
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
                        .offset(y: -280)
            
              
                    
                     //Mark - Score
                    HStack {
                        HStack {
                            Text("Your\nCoins".uppercased())
                                .scoreLabelStyle()
                                .multilineTextAlignment(.trailing)
                            
                            Text("100")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                            
                        }
                        .offset(y: -200)
                        .modifier(ScoreContainerModifier())
                        
                        Spacer()
                        
                        HStack {
                            
                            Text("200")
                                .scoreNumberStyle()
                                .modifier(ScoreNumberModifier())
                            
                            Text("High\nScore".uppercased())
                                .scoreLabelStyle()
                                .multilineTextAlignment(.leading)
                            
                        }
                        .offset(y: -200)
                        .modifier(ScoreContainerModifier())
                    }
                    
                     //Mark - Slot machine
                    VStack(alignment: .center, spacing: 0) {
                         //Mark - REEL N1
                        ZStack {
                            ReelView()
                                .offset(y: -500)
                            Image("gfx-bell")
                                .resizable()
                                .modifier(ImageModifier())
                                .offset(y: -500)
                        }
                        
                        HStack(alignment: .center, spacing: 0) {
                            //Mark - Reel N2
                            ZStack {
                                ReelView()
                                    .offset(y: -500)
                                Image("gfx-seven")
                                    .resizable()
                                    .modifier(ImageModifier())
                                    .offset(y: -500)
                            }
                            
                            Spacer()
                            //Mark - Reel N3
                            ZStack {
                                ReelView()
                                    .offset(y: -500)
                                Image("gfx-cherry")
                                    .resizable()
                                    .modifier(ImageModifier())
                                    .offset(y: -500)
                            }
                        }
                        .frame(maxWidth: 500)
                         //Mark - Spin Button
                        Button( action: {
                            print("Spin the reels")
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
                            .offset(y: 180)
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
                            .offset(y: 180)
                          
                            
                            
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
