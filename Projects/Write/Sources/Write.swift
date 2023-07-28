import SwiftUI
import UI
import WriteInterface
import CoreInterface
import Core

public struct Write: View {
    @Environment(\.dismiss) var dismiss
    @Binding var memo: Memo
    public var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    TextField("제목", text: $memo.title)
                    TextField("본문", text: $memo.body)
                        .lineLimit(100)
                    Button {
                        MemoIOProvider.storeMemo(memo: memo)
                        dismiss()
                    } label: {
                        Text("글 작성 완료")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                }
                .padding()
            }
        }
        .navigationTitle("글 쓰기")
    }
}

struct Write_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Write(memo: .constant(Memo(title: "test1", body: "test2")))
        }
    }
}

public struct WriteCoordinator: View {
    @State private var memo: Memo = Memo(title: "", body: "")
    public var injector: WriteInjector
    public init(injector: WriteInjector) {
        self.injector = injector
        self._memo = .init(initialValue: injector.memo)
        print("memo title : \(injector.memo.title), body : \(injector.memo.body)")
    }
    public var body: some View {
        Write(memo: $memo)
    }
}
