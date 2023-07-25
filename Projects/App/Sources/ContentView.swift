import SwiftUI
import Home
import Write
import WriteInterface

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationDestination(for: WriteInjector.self) { injector in
                    WriteCoordinator(injector: injector)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
