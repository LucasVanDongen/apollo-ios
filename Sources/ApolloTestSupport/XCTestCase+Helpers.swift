import XCTest

public extension XCTestExpectation {
  var numberOfFulfillments: Int {
    value(forKey: "numberOfFulfillments") as! Int
  }
}

public extension XCTestCase {
  func record(_ error: Error, compactDescription: String? = nil, file: StaticString = #filePath, line: UInt = #line) {
    var issue = XCTIssue(type: .assertionFailure, compactDescription: compactDescription ?? String(describing: error))

    issue.associatedError = error

    let location = XCTSourceCodeLocation(filePath: file, lineNumber: line)
    issue.sourceCodeContext = XCTSourceCodeContext(location: location)

    record(issue)
  }
  
  func runActivity<Result>(_ name: String, perform: (XCTActivity) throws -> Result) rethrows -> Result {
    return try XCTContext.runActivity(named: name, block: perform)
  }
}

@testable import Apollo

public extension XCTestCase {
  func makeResultObserver<Operation: GraphQLOperation>(for operation: Operation) -> AsyncResultObserver<GraphQLResult<Operation.Data>, Error> {
    return AsyncResultObserver(testCase: self)
  }
}