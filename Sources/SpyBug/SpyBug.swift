public final class Spy<Input> {
  public internal(set) var invocations: [Input] = []

  public var callsCount: Int { invocations.count }
  public var called: Bool { !invocations.isEmpty }

  public var receivedArguments: Input? { invocations.last }
}

//public func spy<Input, Output>(
//  on closure: inout (Input) -> Output
//) -> Spy<Input> {
//  let spy = Spy<Input>()
//
//  let existingClosure = closure
//
//  closure = { input in
//    spy.invocations.append(input)
//    return existingClosure(input)
//  }
//
//  return spy
//}

public func spy<each Input, Output>(
  on closure: inout (repeat each Input) -> Output
) -> Spy<(repeat each Input)> {
  let spy = Spy<(repeat each Input)>()

  let existingClosure = closure
  closure = { (inputs: repeat each Input) in
    spy.invocations.append((repeat each inputs))
    return existingClosure(repeat each inputs)
  }

  return spy
}
