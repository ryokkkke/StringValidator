//
//  ComposedLengthValidator.swift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2016 moromi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public struct ComposedLengthValidator: Validator {
  private let range: CountableClosedRange<Int>
  private let allowBlank: Bool
  private let allowNil: Bool
  
  public init(range: CountableClosedRange<Int>, allowBlank: Bool = false, allowNil: Bool = false) {
    self.range = range
    self.allowBlank = allowBlank
    self.allowNil = allowNil
  }
  
  public func validate(_ string: String?) -> Bool {
    if allowNil && string == nil { return true }
    guard let string = string else { return false }
    if allowBlank && string.isEmpty { return true }
    
    return range.contains(string.composedCount)
  }
}

fileprivate extension String {
  var composedCount: Int {
    var count = 0
    enumerateSubstrings(in: startIndex..<endIndex, options: .byComposedCharacterSequences, { _,_,_,_  in count += 1})
    return count
  }
}
