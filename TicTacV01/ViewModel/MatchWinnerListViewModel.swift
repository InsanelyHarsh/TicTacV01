//
//  MatchWinnerListViewModel.swift
//  TicTacV01
//
//  Created by Harsh Yadav on 02/09/21.
//

import Foundation
import CoreData
class MatchWinnerListViewModel:ObservableObject{
    @Published var WinnerData = [WinnerDataVM]()
    
    func DelData(data: WinnerDataVM){
        let Data = CoreDataManager.shared.GetDatabyID(id: data.id)
        if let Data = Data{
            CoreDataManager.shared.Delete(Data)
        }
    }
    
    func GetALLData(){
        let winner_data = CoreDataManager.shared.GetAllData()
        DispatchQueue.main.async {
            
            self.WinnerData = winner_data.map(WinnerDataVM.init)
        }
    }
}

struct WinnerDataVM {
    let matchwonby : MatchWonBy
    
    var id:NSManagedObjectID{
        return matchwonby.objectID
    }
    
    var playerA:Bool{
        return matchwonby.playerA
    }
    var playerB:Bool{
        return matchwonby.playerB
    }
    var draw:Bool{
        return matchwonby.draw
    }
}
