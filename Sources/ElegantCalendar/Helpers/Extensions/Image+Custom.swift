// Kevin Li - 3:24 PM - 7/13/20
// RayWo – 8/17/21

import SwiftUI

extension Image {
  
  static var uTurnLeft: Image = {
    guard let image = UIImage(named: "uturn.left", in: .module, with: nil) else {
      fatalError("Error: `ElegantCalendar.xcassets` doesn't exist. Refer to the `README.md` installation on how to resolve this.")
    }
    return Image(uiImage: image)
  }()
  
}
