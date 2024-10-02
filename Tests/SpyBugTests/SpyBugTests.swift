import Testing
@testable import SpyBug

final class Dependency {
  var _doSomething: (Int) -> String = { _ in
    Issue.record("Called _doSomething without overriding")
    return ""
  }

  func doSomething(_ value: Int) -> String {
    _doSomething(value)
  }
}

@Test
func testSpy() {
  let dependency = Dependency()

  dependency._doSomething = { _ in "Hello, World!" }
  let spy = spy(on: &dependency._doSomething)

  let string = dependency.doSomething(1)
  #expect("Hello, World!" == string)
  #expect(spy.called)
}
