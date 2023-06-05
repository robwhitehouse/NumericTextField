import Foundation

// MARK: - Protocol Definition
public protocol SupportedByNumericTextField {
  var allowDecimal: Bool { get }
  var stringRepresentation: String { get set }
}

extension SupportedByNumericTextField {
  static func filterNonNumbers(value: String, allowDecimal: Bool) -> String {
    var alreadyFoundDecimal = false
    return value.filter { char in
      if (char.isWholeNumber) {
        return true
      } else {
        if (allowDecimal) {
          if (
            (String(char) == (Locale.current.decimalSeparator ?? ".")) &&
            !alreadyFoundDecimal
          ) {
            alreadyFoundDecimal = true
            return true
          } else {
            return false
          }
        } else {
          return false
        }
      }
    }
  }
}

/// `Swift.Int` support
extension Int: SupportedByNumericTextField {
  public var allowDecimal: Bool { false }
  public var stringRepresentation: String {
    get {
      self.formatted()
    }
    set {
      let filteredString = Self.filterNonNumbers(value: newValue, allowDecimal: allowDecimal)
      if filteredString.isEmpty {
        self = .zero
      } else {
        if let unwrappedValue = Int(filteredString) {
          self = unwrappedValue
        }
      }
    }
  }
}

/// `Swift.Double` support
extension Double: SupportedByNumericTextField {
  public var allowDecimal: Bool { true }
  public var stringRepresentation: String {
    get {
      self.formatted()
    }
    set {
      let filteredString = Self.filterNonNumbers(value: newValue, allowDecimal: allowDecimal)
      if filteredString.isEmpty {
        self = .zero
      } else {
        if let unwrappedValue = Double(filteredString) {
          self = unwrappedValue
        }
      }
    }
  }
}

/// `Swift.Float` support
extension Float: SupportedByNumericTextField {
  public var allowDecimal: Bool { true }
  public var stringRepresentation: String {
    get {
      self.formatted()
    }
    set {
      let filteredString = Self.filterNonNumbers(value: newValue, allowDecimal: allowDecimal)
      if filteredString.isEmpty {
        self = .zero
      } else {
        if let unwrappedValue = Float(filteredString) {
          self = unwrappedValue
        }
      }
    }
  }
}

/// `CoreFoundation.CGFloat` support
extension CGFloat: SupportedByNumericTextField {
  public var allowDecimal: Bool { true }
  public var stringRepresentation: String {
    get {
      self.formatted()
    }
    set {
      let filteredString = Self.filterNonNumbers(value: newValue, allowDecimal: allowDecimal)
      if filteredString.isEmpty {
        self = .zero
      } else {
        if let unwrappedFloat = Float(filteredString) {
          self = CGFloat(unwrappedFloat)
        }
      }
    }
  }
}
