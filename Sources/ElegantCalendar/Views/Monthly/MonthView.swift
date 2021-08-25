// Kevin Li - 10:53 PM - 6/6/20
// RayWo – 8/18/21

import SwiftUI

struct MonthView: View, MonthlyCalendarManagerDirectAccess {
  
  @Environment(\.calendarTheme) var theme: CalendarTheme
  
  @ObservedObject var calendarManager: MonthlyCalendarManager
  
  let month: Date
  
  private var weeks: [Date] {
    guard let monthInterval = calendar.dateInterval(of: .month, for: month) else {
      return []
    }
    return calendar.generateDates(
      inside: monthInterval,
      matching: calendar.firstDayOfEveryWeek)
  }
  
  private var isWithinSameMonthAndYearAsToday: Bool {
    calendar.isDate(month, equalTo: Date(), toGranularities: [.month, .year])
  }
  
  var body: some View {
    VStack {
      monthYearHeader
        .padding(.leading, CalendarConstants.Monthly.outerHorizontalPadding)
        .padding(.bottom)
        .onTapGesture { self.communicator?.showYearlyView() }
      weeksViewWithDaysOfWeekHeader
      if selectedDate != nil {
        calenderAccessoryView
          .padding(.horizontal,
                   CalendarConstants.Monthly.outerHorizontalPadding)
          .padding(.top)
          .id(selectedDate!)
      }
      Spacer()
    }
    .padding(.top, CalendarConstants.Monthly.topPadding)
    .frame(width: CalendarConstants.Monthly.cellWidth,
           height: CalendarConstants.cellHeight)
  }
  
}

private extension MonthView {
  
  var monthYearHeader: some View {
    HStack {
      VStack(alignment: .leading) {
        monthText
        yearText
      }
      Spacer()
    }
  }
  
  var monthText: some View {
    Text(month.fullMonth.uppercased())
      .font(.system(size: 26))
      .bold()
      .tracking(7)
    // TODO move to datasource?
    //            .foregroundColor(isWithinSameMonthAndYearAsToday ? theme.primary : .primary)
      .foregroundColor(Color.accentColor)
  }
  
  var yearText: some View {
    Text(month.year)
      .font(.system(size: 12))
      .tracking(2)
    // TODO move to datasource?
    //            .foregroundColor(isWithinSameMonthAndYearAsToday ? theme.primary : .gray)
      .foregroundColor(Color.accentColor)
      .opacity(0.95)
  }
  
}

private extension MonthView {
  
  var weeksViewWithDaysOfWeekHeader: some View {
    VStack(spacing: 15) {
      daysOfWeekHeader
      weeksViewStack
    }
  }
  
  var daysOfWeekHeader: some View {
    HStack(spacing: CalendarConstants.Monthly.gridSpacing) {
      ForEach(calendar.dayOfWeekInitials, id: \.self) { dayOfWeek in
        Text(dayOfWeek.uppercased())
          .font(.caption)
          .fontWeight(.bold)
          .frame(width: CalendarConstants.Monthly.dayWidth)
          .foregroundColor(.secondary)
      }
    }
  }
  
  var weeksViewStack: some View {
    VStack {
//    VStack(spacing: CalendarConstants.Monthly.gridSpacing) {
      ForEach(weeks, id: \.self) { week in
        WeekView(calendarManager: self.calendarManager, week: week)
      }
    }
  }
  
}

private extension MonthView {

  var calenderAccessoryView: some View {
    CalendarAccessoryView(calendarManager: calendarManager)
  }

}

private struct CalendarAccessoryView: View, MonthlyCalendarManagerDirectAccess {

  let calendarManager: MonthlyCalendarManager

  @State private var isVisible = false
  
  
  var body: some View {
    VStack {
      GeometryReader { geometry in
        self.datasource?.calendar(viewForSelectedDate: self.selectedDate!,
                                  dimensions: geometry.size)
      }
    }
    .onAppear(perform: makeVisible)
  }

  private func makeVisible() {
    isVisible = true
  }
}

struct MonthView_Previews: PreviewProvider {
  static var previews: some View {
    LightDarkThemePreview {
      MonthView(calendarManager: .mock, month: Date())
      
      MonthView(calendarManager: .mock, month: .daysFromToday(45))
    }
  }
}
