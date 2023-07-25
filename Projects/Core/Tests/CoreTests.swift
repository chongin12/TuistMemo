import XCTest
@testable import CoreTesting
@testable import Core
@testable import CoreInterface

final class CoreTests: XCTestCase {
    
    let memoDataController = MemoDataController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        memoDataController.deleteAllMemos()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateMemo() throws {
        let data = CoreTesting.sampleMemo
        memoDataController.storeMemo(memo: data)
        let result = memoDataController.fetchMemos()[0]
        
        XCTAssertEqual(data.title, result.title)
        XCTAssertEqual(data.body, result.body)
    }
    
    func testCreateDuplicateMemo() throws {
        let data = CoreTesting.sampleMemo
        memoDataController.storeMemo(memo: data)
        var anotherData = data
        anotherData.body = "sswaasdfasdfasdf"
        memoDataController.storeMemo(memo: anotherData)
        
        let result = memoDataController.fetchMemos()
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0], anotherData)
    }
    
    func testDeleteMemo() throws {
        let data = CoreTesting.sampleMemos
        data.forEach { memo in
            memoDataController.storeMemo(memo: memo)
        }
        let memos = memoDataController.fetchMemos()
        let initialCount = memos.count
        
        // Delete the first Memo object
        memoDataController.deleteMemo(memo: memos[0])
        
        let result = memoDataController.fetchMemos()
        let deletedData = memos.filter { $0 == memos[0] }
        XCTAssertEqual(deletedData.count, 1)
        let deletedMemo = deletedData[0]
        
        XCTAssertEqual(result.count, initialCount - 1)
        XCTAssertFalse(result.contains { $0 == deletedMemo })
    }

    func testFetchMemos() throws {
        
        let data = CoreTesting.sampleMemos
        data.forEach { memo in
            memoDataController.storeMemo(memo: memo)
        }
        
        let result = memoDataController.fetchMemos()
        
        for i in 0..<data.count {
            XCTAssertEqual(data[i].title, result[i].title)
            XCTAssertEqual(data[i].body, result[i].body)
        }
        
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
