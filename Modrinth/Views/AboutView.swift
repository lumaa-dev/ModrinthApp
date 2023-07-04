//Made by Lumaa

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Text("This app has been conceived for iPhones using iOS 16 or more\nNot related to Modrinth in any way.\n\nThis app was made in SwiftUI by Lumaa. Find out more on https://lumaa.fr/")
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(10)
        }
    }
}
