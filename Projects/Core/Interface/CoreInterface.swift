import Foundation
import CoreData

protocol CoreInterface {}

public struct Memo: Identifiable, Hashable {
    public var title: String
    public var body: String

    public var id: UUID

    public init(title: String, body: String, id: UUID = UUID()) {
        self.title = title
        self.body = body
        self.id = id
    }

    public init(memoEntity: MemoEntity) {
        self.title = memoEntity.title ?? ""
        self.body = memoEntity.body ?? ""
        self.id = memoEntity.id ?? UUID()
    }
}
