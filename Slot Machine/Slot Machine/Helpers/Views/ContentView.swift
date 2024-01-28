//
//  ContentView.swift
//  Slot Machine
//
//  Created by Nicolai Bodean on 28.01.2024.
//

import SwiftUI

struct ContentView: View {
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
                        .modifier(ScoreContainerModifier())
                    }
                    
                     //Mark - Slot machine
                     //Mark - Footer
                    
                    Spacer()
                    
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
                        print("Info View")
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
            .frame(height: 900)
           
    }
}

#Preview {
    ContentView()
}
