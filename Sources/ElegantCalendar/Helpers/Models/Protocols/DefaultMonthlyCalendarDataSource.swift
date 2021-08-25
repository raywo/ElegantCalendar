//
//  DefaultMonthlyCalendarDataSource.swift
//  DefaultMonthlyCalendarDataSource
//
//  Created by Ray Wojciechowski on 21.08.21.
//

import Foundation
import SwiftUI

public extension MonthlyCalendarDataSource {
  
  func calendar(foregroundColorForDate date: Date,
                scheme: ColorScheme) -> Color { Color.primary }
  
  func calendar(backgroundColorOpacityForDate date: Date) -> Double { 1 }
  
  func calendar(backgroundColorForDate date: Date) -> [Color] { [] }
  
  func calendar(showEventDotForDate date: Date) -> Bool { false }
  
  func calendar(auxDotsColorsForDate date: Date) -> [Color] { [] }
  
  func calendar(canSelectDate date: Date) -> Bool { true }
  
  func calendar(viewForSelectedDate date: Date,
                dimensions size: CGSize) -> AnyView {
    DefaultCalendarAccessoryView(date: date)
      .frame(width: size.width, height: size.height)
      .erased
  }
}

struct DefaultCalendarAccessoryView: View {
  @State var date: Date
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading) {
          dayOfWeekWithMonthAndDayText
          if isNotYesterdayTodayOrTomorrow {
            daysFromTodayText
          }
        }
        Spacer()
      }
      Spacer()
    }
  }
  
  private var dayOfWeekWithMonthAndDayText: some View {
    let monthDayText: String
    if numberOfDaysFromTodayToSelectedDate == -1 {
      monthDayText = "Yesterday"
    } else if numberOfDaysFromTodayToSelectedDate == 0 {
      monthDayText = "Today"
    } else if numberOfDaysFromTodayToSelectedDate == 1 {
      monthDayText = "Tomorrow"
    } else {
      monthDayText = date.dayOfWeekWithMonthAndDay
    }
    
    return Text(monthDayText.uppercased())
      .font(.subheadline)
      .bold()
  }
  
  private var daysFromTodayText: some View {
    let isBeforeToday = numberOfDaysFromTodayToSelectedDate < 0
    let daysDescription = isBeforeToday ? "DAYS AGO" : "DAYS FROM TODAY"
    
    return Text("\(abs(numberOfDaysFromTodayToSelectedDate)) \(daysDescription)")
      .font(.system(size: 10))
      .foregroundColor(.gray)
  }
  
  private var numberOfDaysFromTodayToSelectedDate: Int {
    let calendar = Calendar.current
    let startOfToday = calendar.startOfDay(for: Date())
    let startOfSelectedDate = calendar.startOfDay(for: date)
    return calendar.dateComponents([.day], from: startOfToday, to: startOfSelectedDate).day!
  }
  
  private var isNotYesterdayTodayOrTomorrow: Bool {
    abs(numberOfDaysFromTodayToSelectedDate) > 1
  }
}
