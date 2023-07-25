import SwiftUI

struct UI {}

public protocol BaseCoordinator: Hashable where Supply: Hashable {
    associatedtype Supply
    var supply: Supply { get set }
    
    associatedtype V: View
    func show() -> V
}

public protocol BaseBindableCoordinator: Hashable {
    associatedtype Supply
    var supply: Binding<Supply> { get }

    associatedtype V: View
    func show() -> V
}
