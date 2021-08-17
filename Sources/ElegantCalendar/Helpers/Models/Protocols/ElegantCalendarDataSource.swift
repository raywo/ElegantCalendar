// Kevin Li - 5:19 PM - 6/14/20
// RayWo – 8/17/21

import SwiftUI

public protocol ElegantCalendarDataSource: MonthlyCalendarDataSource, YearlyCalendarDataSource { }

public protocol MonthlyCalendarDataSource {
  func calendar(backgroundColorOpacityForDate date: Date) -> Double
  func calendar(backgroundColorForDate date: Date) -> Color?
  func calendar(canSelectDate date: Date) -> Bool
  func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView
}


public extension MonthlyCalendarDataSource {
  func calendar(backgroundColorOpacityForDate date: Date) -> Double { 1 }
  
  func calendar(backgroundColorForDate date: Date) -> Color? { nil }
  
  func calendar(canSelectDate date: Date) -> Bool { true }
  
  func calendar(viewForSelectedDate date: Date,
                dimensions size: CGSize) -> AnyView {
    EmptyView().erased
  }
}


public protocol YearlyCalendarDataSource {
  func calendar(backgroundColorForDate date: Date) -> Color?
  func calendar(isRangeStartForDate date: Date) -> Bool
  func calendar(isRangeEndForDate date: Date) -> Bool
}

extension YearlyCalendarDataSource {
  func calendar(backgroundColorForDate date: Date) -> Color? { nil }
  
  func calendar(isRangeStartForDate date: Date) -> Bool { false }
  
  func calendar(isRangeEndForDate date: Date) -> Bool { false }
}
