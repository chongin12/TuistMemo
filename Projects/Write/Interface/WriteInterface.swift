import Foundation
import CoreInterface
import SwiftUI

protocol WriteInterface {}

public struct WriteInjector: Hashable {
    public var memo: Memo
    public init(memo: Memo? = nil) {
        if let memo {
            self.memo = memo
        } else {
            self.memo = Memo(title: "", body: "")
        }
    }
}
