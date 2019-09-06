//
//  ViewController.swift
//  TicTacToe
//
//  Created by Emil Nielsen on 05/09/2019.
//  Copyright © 2019 Emil Nielsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var fields = [0, 0, 0, 0, 0, 0, 0, 0, 0] //0=empty, 1=x, 2=o
    private let winnerStates = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

    private var cross = #imageLiteral(resourceName: "cross")
    private var circle = #imageLiteral(resourceName: "nought")
    private var player = 1 // 1=x  2=o
    private var result = ""

    @IBAction private func fieldPressed(_ sender: UIButton) {
        if fields[sender.tag] == 0 {
            fields[sender.tag] = player
            if player == 1 {
                sender.setBackgroundImage(cross, for: .normal)
                player = 2
            } else if (player == 2) {
                sender.setBackgroundImage(circle, for: .normal)
                player = 1
            }
            if isGameOver() {
                showResult(result)
            }
        }
    }

    private func isGameOver() -> Bool {
        if checkWinner(player: 1) {
            result = "Cross wins"
            return true
        }
        if checkWinner(player: 2) {
            result = "Circle wins"
            return true
        }
        for field in fields {
            if field == 0 {
                return false
            }
        }
        result = "Draw"
        return true
    }

    private func checkWinner(player: Int) -> Bool {
        for combination in winnerStates {
            if (fields[combination[0]] == player) && (fields[combination[1]] == player) && fields[combination[2]] == player {
                return true
            }
        }
        return false
    }

    private func showResult(_ result: String) {
        let alertController = UIAlertController(title: result, message: "Press OK to play again", preferredStyle: UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            _ in
            for view in self.view.subviews {
                if let btn = view as? UIButton {
                    btn.setBackgroundImage(nil, for: .normal)
                }
            }
            
            self.fields = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        }))

        present(alertController, animated: true, completion: nil)
    }

}

