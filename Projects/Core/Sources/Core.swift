import Foundation
import CoreInterface
import SwiftUI
import CoreData

struct Core {}

public class MemoIOProvider {
    static let memoDataController = MemoDataController()
    public static func loadMemos() -> [Memo] {
        memoDataController.fetchMemos()
    }
    
    public static func storeMemo(memo: Memo) {
        memoDataController.storeMemo(memo: memo)
    }
    
    public static func deleteMemo(memo: Memo) {
        memoDataController.deleteMemo(memo: memo)
    }
}

extension Array<Memo> {
    public func toBindings() -> [Binding<Memo>] {
        self.map { memo in
            .constant(memo)
        }
    }
}

public final class MemoDataController {
    var persistentContainer: NSPersistentContainer
    
    public init() {
        /// momdname : 모델 이름
        /// modelURL : 해당 모델이 있는 위치 (번들의 identifier는 {organization}.{module 이름} 으로 구성되어있음.

        let momdName = "MemoModel"
        guard let modelURL = Bundle(identifier: "dev.chongin.CoreInterface")?.url(forResource: momdName, withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: "MemoModel", managedObjectModel: mom)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print("storeDescription : \(storeDescription)")
        })

        self.persistentContainer = container
    }

    private var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }

    private var entity: NSEntityDescription? {
        NSEntityDescription.entity(forEntityName: "MemoEntity", in: context)
    }

    public func storeMemo(memo: Memo) {
        if let entity {
            do {
                let memos = try self.findMemosByID(id: memo.id)
                if !memos.isEmpty {
                    updateMemo(from: memos[0], to: memo)
                    return
                }
            } catch {
                print(error.localizedDescription)
            }
            let memoObject = NSManagedObject(entity: entity, insertInto: context)
            memoObject.setValue(memo.title, forKey: "title")
            memoObject.setValue(memo.body, forKey: "body")
            memoObject.setValue(memo.id, forKey: "id")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    public func fetchMemos() -> [Memo] {
        var memos = [Memo]()
        do {
            let memoObjects = try context.fetch(MemoEntity.fetchRequest())
            memos = memoObjects.map { Memo(memoEntity: $0) }
        } catch {
            print(error.localizedDescription)
        }
        
        return memos
    }
    
    private func updateMemo(from src: MemoEntity, to dest: Memo) {
        guard let id = src.id, id == dest.id else { return }
        src.title = dest.title
        src.body = dest.body
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteMemo(memo: Memo) {
        do {
            // Fetch the objects using the fetch request
            let objects = try findMemosByID(id: memo.id)
            if let object = objects.first {
                context.delete(object)
            }
        } catch {
            print("Error fetching objects: \(error.localizedDescription)")
        }
    }
    
    public func deleteAllMemos() {
        do {
            let memoObjects = try context.fetch(MemoEntity.fetchRequest())
            for memoObject in memoObjects {
                context.delete(memoObject)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func findMemosByID(id: UUID) throws -> [MemoEntity] {
        var memoEntities = [MemoEntity]()
        let fetchRequest: NSFetchRequest<MemoEntity> = MemoEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            memoEntities = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching objects: \(error.localizedDescription)")
        }
        
        return memoEntities
    }
}
