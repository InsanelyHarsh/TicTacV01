//
//  CoreDataManager.swift
//  TicTacV01
//
//  Created by Harsh Yadav on 01/09/21.
//

import Foundation
import CoreData
class CoreDataManager{
    let PersistentContainer:NSPersistentContainer
    static let shared  = CoreDataManager()
    
    private init(){
        PersistentContainer = NSPersistentContainer(name: "CDplayerData")
        PersistentContainer.loadPersistentStores { description, error in
            if let error = error{
                fatalError("failed to init. Error: \(error)")
            }
        }
    }
    
    func SaveData(){
        do{
            try PersistentContainer.viewContext.save()
            print("saved data successfully!")
        }
        catch{
            print("Failed to Save Data")
        }
    }
    
    func GetAllData() -> [MatchWonBy]{
        let FetchRequest : NSFetchRequest<MatchWonBy> = MatchWonBy.fetchRequest()
        do{
            return try PersistentContainer.viewContext.fetch(FetchRequest)
        }
        catch{
            return [MatchWonBy]()
        }
    }
    
    func Delete(_ Data:MatchWonBy){
        PersistentContainer.viewContext.delete(Data)
        do{
            try PersistentContainer.viewContext.save()
            print("successfully deleted")
        }
        catch{
            PersistentContainer.viewContext.rollback()
            print("failed to delete")
        }
    }
    


    
    func GetDatabyID(id:NSManagedObjectID) -> MatchWonBy?{
        do{
            return try PersistentContainer.viewContext.existingObject(with: id) as? MatchWonBy
        }
        catch{
            print(error)
            return nil
        }
    }
}

/*
 public func clearAllCoreData() {
     let entities = self.persistentContainer.managedObjectModel.entities
     entities.flatMap({ $0.name }).forEach(clearDeepObjectEntity)
 }

 private func clearDeepObjectEntity(_ entity: String) {
     let context = self.persistentContainer.viewContext

     let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
     let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

     do {
         try context.execute(deleteRequest)
         try context.save()
     } catch {
         print ("There was an error")
     }
 }

 */
