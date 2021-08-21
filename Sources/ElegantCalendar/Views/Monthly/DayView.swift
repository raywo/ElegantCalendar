// Kevin Li - 11:30 PM - 6/6/20
// RayWo – 8/17/21

import SwiftUI

struct DayView: View, MonthlyCalendarManagerDirectAccess {
  
  @Environment(\.calendarTheme) var theme: CalendarTheme
  
  @ObservedObject var calendarManager: MonthlyCalendarManager
  
  let week: Date
  let day: Date
  
  private var isDayWithinDateRange: Bool {
    day >= calendar.startOfDay(for: startDate) && day <= endDate
  }
  
  private var isDayWithinWeekMonthAndYear: Bool {
    calendar.isDate(week, equalTo: day, toGranularities: [.month, .year])
  }
  
  private var canSelectDay: Bool {
    datasource?.calendar(canSelectDate: day) ?? true
  }
  
  // TODO necessary anymore?
  private var isDaySelectableAndInRange: Bool {
    isDayWithinDateRange && isDayWithinWeekMonthAndYear && canSelectDay
  }
  
  private var isDayToday: Bool {
    calendar.isDateInToday(day)
  }
  
  private var isSelected: Bool {
    guard let selectedDate = selectedDate else { return false }
    return calendar.isDate(selectedDate, equalTo: day, toGranularities: [.day, .month, .year])
  }
  
  var body: some View {
    VStack(spacing: 7) {
      Text(numericDay)
        .font(.footnote)
        .foregroundColor(foregroundColor)
        .frame(width: CalendarConstants.Monthly.dayWidth,
               height: CalendarConstants.Monthly.dayWidth - 15)
        .background(backgroundColor)
        .clipShape(Capsule())
        .opacity(opacity)
        .overlay(isSelected ? CircularSelectionView() : nil)
        .onTapGesture(perform: notifyManager)
      
      auxColorDots
    }
  }
  
  private var numericDay: String {
    String(calendar.component(.day, from: day))
  }
  
  private var foregroundColor: Color {
    // TODO move to datasource?
    isDayToday ? .white : .primary
  }
  
  private var backgroundColor: Color {
    let themeColor = theme.primary
    var result = themeColor
    
    if let color = datasource?.calendar(backgroundColorForDate: day) {
      result = color
    }
    
    return isDayToday ? Color.accentColor : result
  }
  
  private var auxColorDots: AnyView {
    let width = CGFloat(5)
    let maxDots = 4
    
    guard var colors = datasource?.calendar(auxDotsColorsForDate: day),
          colors.count > 1 else {
            return Circle()
              .fill(.clear)
              .frame(width: width, height: width)
              .erased
          }
    
    if colors.count > maxDots {
      colors.removeSubrange(maxDots..<colors.count)
    }
    
    return HStack(spacing: 3) {
      ForEach(colors, id: \.self) { color in
        Circle()
          .fill(color)
          .frame(width: width, height: width)
      }
    }.erased
  }
  
  private var opacity: Double {
    // TODO move to datasource?
    if isDayToday { return 0.8 }
    if !isDaySelectableAndInRange { return 0.25 }
    
    return datasource?.calendar(backgroundColorOpacityForDate: day) ?? 1
  }
  
  private func notifyManager() {
    guard isDayWithinDateRange && canSelectDay else { return }
    
    if isDayToday || isDayWithinWeekMonthAndYear {
      calendarManager.dayTapped(day: day, withHaptic: true)
    }
  }
  
}

private struct CircularSelectionView: View {
  
  @State private var startBounce = false
  
  var body: some View {
    Capsule()
      .stroke(Color.accentColor, lineWidth: 2)
      .frame(width: radius, height: radius - 15)
      .opacity(startBounce ? 1 : 0)
      .animation(.interpolatingSpring(stiffness: 150, damping: 10))
      .onAppear(perform: startBounceAnimation)
  }
  
  private var radius: CGFloat {
    startBounce ? CalendarConstants.Monthly.dayWidth + 6 : CalendarConstants.Monthly.dayWidth + 25
  }
  
  private func startBounceAnimation() {
    startBounce = true
  }
  
}

struct DayView_Previews: PreviewProvider {
  static var previews: some View {
    LightDarkThemePreview {
      DayView(calendarManager: .mock, week: Date(), day: Date())
      
      DayView(calendarManager: .mock, week: Date(), day: .daysFromToday(3))
    }
  }
}
