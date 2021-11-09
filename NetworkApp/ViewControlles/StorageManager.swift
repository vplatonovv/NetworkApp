//
//  StorageManager.swift
//  NetworkApp
//
//  Created by Слава Платонов on 11.10.2021.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    // MARK: - Core Data stack
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NetworkApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    // MARK: - Public Methods
    func fetchData(completion: (Result<[Characters], Error>) -> Void) {
        let fetchRequest = Characters.fetchRequest()
        do {
            let characters = try viewContext.fetch(fetchRequest)
            completion(.success(characters))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func save(name: String, birthday: String, img: String, status: String, nickname: String) {
        let characters = Characters(context: viewContext)
        characters.name = name
        characters.birthday = birthday
        characters.img = img
        characters.status = status
        characters.nickname = nickname
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
