//
//  AddWinnerViewModel.swift
//  TicTacV01
//
//  Created by Harsh Yadav on 02/09/21.
//

import Foundation
class AddWinnerViewModel:ObservableObject{
    
    var PlayerA:Bool = false
    var PlayerB:Bool = false
    var Draw:Bool = false
    
    func SaveWinnerDetails(){
        let manager = CoreDataManager.shared

        let matchWonBy = MatchWonBy(context: manager.PersistentContainer.viewContext)
        matchWonBy.playerA = PlayerA
        matchWonBy.playerB = PlayerB
        matchWonBy.draw = Draw
        manager.SaveData()
        
    }
}
