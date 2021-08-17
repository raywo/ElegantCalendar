// Kevin Li - 6:10 PM - 7/14/20
// RayWo - 8/17/21

import SwiftUI

public struct CalendarTheme: Equatable, Hashable {
  public let primary: Color
  
  public init(primary: Color) {
    self.primary = primary
  }
}

public extension CalendarTheme {
  static let allThemes: [CalendarTheme] = [
    .brilliantViolet,
    .craftBrown,
    .fluorescentPink,
    .kiwiGreen,
    .mauvePurple,
    .orangeYellow,
    .red,
    .royalBlue
  ]
  
  static let brilliantViolet = CalendarTheme(primary: .brilliantViolet)
  static let craftBrown = CalendarTheme(primary: .craftBrown)
  static let fluorescentPink = CalendarTheme(primary: .fluorescentPink)
  static let kiwiGreen = CalendarTheme(primary: .kiwiGreen)
  static let mauvePurple = CalendarTheme(primary: .mauvePurple)
  static let orangeYellow = CalendarTheme(primary: .orangeYellow)
  static let red = CalendarTheme(primary: .red)
  static let royalBlue = CalendarTheme(primary: .royalBlue)
}

extension CalendarTheme {
  static let `default`: CalendarTheme = .royalBlue
}

struct CalendarThemeKey: EnvironmentKey {
  static let defaultValue: CalendarTheme = .default
}

extension EnvironmentValues {
  var calendarTheme: CalendarTheme {
    get { self[CalendarThemeKey.self] }
    set { self[CalendarThemeKey.self] = newValue }
  }
}

private extension Color {
  static let brilliantViolet = Color("brilliantViolet", bundle: .module)
  static let craftBrown = Color("craftBrown", bundle: .module)
  static let fluorescentPink = Color("fluorescentPink", bundle: .module)
  static let kiwiGreen = Color("kiwiGreen", bundle: .module)
  static let mauvePurple = Color("mauvePurple", bundle: .module)
  static let orangeYellow = Color("orangeYellow", bundle: .module)
  static let red = Color("red", bundle: .module)
  static let royalBlue = Color("royalBlue", bundle: .module)  
}
