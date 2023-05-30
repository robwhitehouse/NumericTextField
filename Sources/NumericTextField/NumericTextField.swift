import SwiftUI

public struct NumericTextField<TFNumber: SupportedByNumericTextField, LabelView: View>: View {
  @Binding private var number: TFNumber
  var label: LabelView
    
  @ViewBuilder public var body: some View {
    TextField(text: $number.stringRepresentation) {
      label
    }
    #if os(iOS)
    .keyboardType(number.allowDecimal ? .decimalPad : .numberPad)
    #endif
  }
  
  public init(number: Binding<TFNumber>, @ViewBuilder label: @escaping () -> LabelView) {
    self.label = label()
    self._number = number
  }
}

// MARK: - SwiftUI Previews
struct NumericTextField_Previews: PreviewProvider {
  struct NumericTextFieldPreview: View {
    @State private var int: Int = 14
    @State private var float: Float = 0.12312
    @State private var double: Double = 44.56
    
    var body: some View {
      NavigationStack {
        Form {
          NumericTextField(number: $int) {
            Text("Integer")
          }
          Text("Integer Value: \(int.formatted())")
          NumericTextField(number: $float) {
            Text("Float")
          }
          Text("Float Value: \(float.formatted())")
          NumericTextField(number: $double) {
            Text("Double")
          }
          Text("Double Value: \(double.formatted())")
        }
        .formStyle(.grouped)
      }
    }
  }
  
  static var previews: some View {
    NumericTextFieldPreview()
  }
}
