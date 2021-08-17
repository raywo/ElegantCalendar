//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Ray Wojciechowski on 17.08.21.
//

import SwiftUI

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius,
                                                height: radius))
    
    return Path(path.cgPath)
  }
}

extension View {
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius, corners: corners))
  }
}

struct RoundedCorners_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Text("Hello World")
        .padding()
        .background(Color("fluorescentPink", bundle: Bundle.module))
        .cornerRadius(20, corners: .topLeft)
        .cornerRadius(20, corners: .bottomRight)
      
      HStack {
        Text("Start")
          .padding()
          .background(Color("fluorescentPink", bundle: Bundle.module))
          .cornerRadius(20, corners: .topLeft)
          .cornerRadius(20, corners: .bottomLeft)
        
        Text("End")
          .padding()
          .background(Color("fluorescentPink", bundle: Bundle.module))
          .cornerRadius(20, corners: .topRight)
          .cornerRadius(20, corners: .bottomRight)
      }
    }
  }
}
