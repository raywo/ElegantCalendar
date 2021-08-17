// Kevin Li - 7:19 PM - 6/13/20
// RayWo – 8/17/21

import SwiftUI

struct SmallDayView: View, YearlyCalendarManagerDirectAccess {
  
  let calendarManager: YearlyCalendarManager
  
  let week: Date
  let day: Date
  
  private var isDayWithinDateRange: Bool {
    day >= calendar.startOfDay(for: startDate) && day <= endDate
  }
  
  private var isDayWithinWeekMonthAndYear: Bool {
    calendar.isDate(week, equalTo: day, toGranularities: [.month, .year])
  }
  
  private var isDayToday: Bool {
    calendar.isDateInToday(day)
  }
  
  var body: some View {
    Text(numericDay)
      .font(.system(size: 8))
      .foregroundColor(isDayToday ? .systemBackground : .primary)
      .frame(width: CalendarConstants.Yearly.dayWidth, height: CalendarConstants.Yearly.dayWidth)
      .background(backgroundView)
      .opacity(isDayWithinDateRange && isDayWithinWeekMonthAndYear ? 1 : 0)
  }
  
  private var numericDay: String {
    String(calendar.component(.day, from: day))
  }
  
  private var backgroundColor: Color {
    datasource?.calendar(backgroundColorForDate: day) ?? .clear
  }
  
  private var backgroundView: AnyView {
    if isDayToday {
      return AnyView(Color.accentColor)
    }
    
    if let datasource = datasource {
      if datasource.calendar(isRangeStartForDate: day) {
        return AnyView(backgroundColor
                        .cornerRadius(6.5, corners: .topLeft)
                        .cornerRadius(6.5, corners: .bottomLeft)
        )
      }
      
      if datasource.calendar(isRangeEndForDate: day) {
        return AnyView(backgroundColor
                        .cornerRadius(6.5, corners: .topRight)
                        .cornerRadius(6.5, corners: .bottomRight)
        )
      }
    }
    
    return AnyView(backgroundColor)
  }
}

struct SmallDayView_Previews: PreviewProvider {
  static var previews: some View {
    LightDarkThemePreview {
      SmallDayView(calendarManager: .mock, week: Date(), day: Date())
      
      SmallDayView(calendarManager: .mock, week: Date(), day: .daysFromToday(3))
    }
  }
}
