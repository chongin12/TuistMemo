import Foundation

public protocol HomeInterface {}

//public struct HomeCoordinator: BaseCoordinator {
//    public static func == (lhs: HomeCoordinator, rhs: HomeCoordinator) -> Bool {
//        lhs.supply == rhs.supply
//    }
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(supply)
//    }
//
//    public var supply: String
//
//    public init(supply: String) {
//        self.supply = supply
//    }
//
//    @ViewBuilder
//    public func show() -> some View {
//        Text("\(supply)")
//        NavigationLink(value: HomeCoordinator(supply: "qwer")) {
//            Text("Click Here!!2")
//        }
//    }
//}

//public protocol HomeCoordinator: BaseCoordinator {
//    var supply: String { get set }
//}

public struct HomeInjector: Hashable {
    public init() { }
}
