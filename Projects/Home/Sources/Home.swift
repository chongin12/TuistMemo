import SwiftUI
import HomeInterface
import UI
import WriteInterface
import CoreInterface
import Core

public struct Home: View {
    @State private var memoList: [Memo] = []
    public init() { }
    public var body: some View {
        List {
            ForEach(memoList) { memo in
                NavigationLink(value: WriteInjector(memo: memo)) {
                    Text(memo.title)
                }
            }
            .onDelete(perform: deleteMemo)
        }
        .navigationTitle("Memo")
        .toolbar {
            ToolbarItem {
                NavigationLink(value: WriteInjector()) {
                    Image(systemName: "plus.circle")
                }
            }
        }
        .task {
            memoList = MemoIOProvider.loadMemos()
        }
    }
    private func deleteMemo(at offsets: IndexSet) {
        offsets.forEach { index in
            let memo = memoList[index]
            MemoIOProvider.deleteMemo(memo: memo)
        }
        
        memoList = MemoIOProvider.loadMemos()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Home()
                .navigationDestination(for: WriteInjector.self) { injector in
                    EmptyView()
                }
        }
    }
}

public struct HomeCoordinator: View {
    public var injector: HomeInjector
    public init(injector: HomeInjector) {
        self.injector = injector
    }
    
    public var body: some View {
        Home()
    }
}
