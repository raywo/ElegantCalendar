// Kevin Li - 7:19 PM - 6/13/20
// RayWo – 8/17/21

import SwiftUI

struct SmallDayView: View, YearlyCalendarManagerDirectAccess {
  
  let calendarManager: YearlyCalendarManager
  
  let week: Date
  let day: Date
  
  var body: some View {
    Text(numericDay)
      .font(.system(size: 8, weight: fontWeight))
      .foregroundColor(isDayToday ? .white : .primary)
      .frame(width: CalendarConstants.Yearly.dayWidth, height: CalendarConstants.Yearly.dayWidth)
      .background(backgroundView.opacity(opacity))
      .opacity(isDayWithinDateRange && isDayWithinWeekMonthAndYear ? 1 : 0)
  }
  
  private var isDayWithinDateRange: Bool {
    day >= calendar.startOfDay(for: startDate) && day <= endDate
  }
  
  private var isDayWithinWeekMonthAndYear: Bool {
    calendar.isDate(week, equalTo: day, toGranularities: [.month, .year])
  }
  
  private var isDayToday: Bool {
    calendar.isDateInToday(day)
  }
  
  private var numericDay: String {
    String(calendar.component(.day, from: day))
  }
  
  private var fontWeight: Font.Weight {
    isDayToday ? .bold : .regular
  }
  
  private var opacity: Double {
    datasource?.calendar(backgroundColorOpacityForDate: day) ?? 0
  }
  
  private var backgroundColors: [Color] {
    datasource?.calendar(backgroundColorForDate: day) ?? []
  }
  
  private var backgroundView: AnyView {
    if isDayToday {
      return AnyView(Color.accentColor
                      .overlay(Rectangle().strokeBorder()))
    }
    
    if let datasource = datasource {
      if datasource.calendar(isRangeStartForDate: day) {
        return AnyView(coloredBackgroundView
                        .cornerRadius(6.5, corners: .topLeft)
                        .cornerRadius(6.5, corners: .bottomLeft)
        )
      }
      
      if datasource.calendar(isRangeEndForDate: day) {
        return AnyView(coloredBackgroundView
                        .cornerRadius(6.5, corners: .topRight)
                        .cornerRadius(6.5, corners: .bottomRight)
        )
      }
    }
    
    return AnyView(coloredBackgroundView)
  }
  
  private var coloredBackgroundView: some View {
    return GeometryReader { geometry in
      HStack(spacing: 0) {
        ForEach(backgroundColors, id: \.self) { color in
          color
            .frame(width: geometry.size.width / CGFloat(backgroundColors.count))
        }
      }
    }
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
