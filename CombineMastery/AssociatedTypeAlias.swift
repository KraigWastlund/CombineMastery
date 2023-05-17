//
//  AssociatedTypeAlias.swift
//  CombineMastery
//
//  Created by Kraig Wastlund on 5/9/23.
//

import SwiftUI

protocol GameScore {
    associatedtype TeamScore
    func calculateWinner(teamOne: TeamScore, teamTwo: TeamScore) -> String
}

struct BasketballGame: GameScore {
    typealias TeamScore = Float
    
    func calculateWinner(teamOne: Float, teamTwo: Float) -> String {
        return ""
    }
}

struct FootballGame: GameScore {
    
    func calculateWinner(teamOne: Int, teamTwo: Int) -> String {
        if teamOne > teamTwo {
            return "Team One"
        } else if teamOne == teamTwo {
            return "Tie"
        } else {
            return "Team Two"
        }
    }
}

struct ScoreView: View {
    
    let footballGame = FootballGame()
    @State var winner = "Tie"
    @State var teamOneScore = 0
    @State var teamTwoScore = 0
    
    var body: some View {
        VStack {
            Button("Who wins?") {
                teamOneScore = Array(0...100).randomElement()!
                teamTwoScore = Array(0...100).randomElement()!
                winner = footballGame.calculateWinner(teamOne: teamOneScore, teamTwo: teamTwoScore)
            }
            Text("Team One: \(teamOneScore)")
            Text("Team Two: \(teamTwoScore)")
            Text(winner)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}

