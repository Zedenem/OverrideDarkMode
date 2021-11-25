//
/*! @copyright 2021 ___ORGANIZATIONNAME___ */

import SwiftUI

struct SwiftUIView: View {
  @Environment(\.colorScheme) private var colorScheme

  private var backgroundColor: Color {
    switch colorScheme {
    case .light:
      return .red
    case .dark:
      return .green
    @unknown default:
      return .white
    }
  }

  var body: some View {
    Group {
      Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    .padding()
    .background(backgroundColor)
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIView()

  }
}
