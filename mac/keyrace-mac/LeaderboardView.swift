//
//  LeaderboardView.swift
//  keyrace-mac
//
//  Created by Jessie Frazelle on 2/17/21.
//

import Foundation
import AppKit

struct PlayerScore {
    var username = ""
    var score = 0
}

class LeaderboardView: NSGridView {
    var leaderboard = [PlayerScore]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setContentHuggingPriority(.init(600), for: .vertical)
    }
    
    func setup(_ leaderboard: [PlayerScore]) {
        self.leaderboard = leaderboard
        
        self.prepareForReuse()
        
        /* Remove all the old rows */
        if self.numberOfRows > 1 {
            for _ in 0...(self.numberOfRows - 1) {
                self.removeRow(at: 0)
            }
        }
        
        // Add the new rows.
        for (i, player) in self.leaderboard.enumerated() {
            print(player, i)
            // Setup the text view for the username.
            let usernameView = NSTextView()
            usernameView.string = "@" + player.username
            usernameView.string = usernameView.string
            usernameView.textStorage?.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
            usernameView.backgroundColor = .clear
            usernameView.textContainerInset = NSSizeFromString("10")
            usernameView.sizeToFit()
            
            // Setup the text view for the score.
            let scoreView = NSTextView()
            scoreView.string = String(format: "%d", player.score)
            if i == 0 {
                // Make the winner fancy.
                scoreView.string += " 🎉"
            }
            scoreView.textStorage?.font = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
            scoreView.backgroundColor = .clear
            scoreView.sizeToFit()
            
            let row = self.addRow(with: [usernameView, scoreView])
            row.height = usernameView.frame.height
            if i == 0 {
                row.topPadding = 10
            } else if i == self.leaderboard.count - 1 {
                row.bottomPadding = 10
            }
        }
        
        if self.leaderboard.count > 0 {
            // Set the column widths
            self.column(at: 0).width = 175
            self.column(at: 1).width = 175
        }
        
        print("rows", self.numberOfRows, "columns", self.numberOfColumns)
        
        // Update the layers.
        /*self.isHidden = true
        print("before" , self.needsDisplay)
        self.setNeedsDisplay(self.frame)
        self.viewWillDraw()
        self.isHidden = false
        print("after", self.needsDisplay)*/
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
