//Made by Lumaa

import SwiftUI

@main
struct ModrinthApp: App {
    @State var displayPreferences: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .toolbar() {
                    ToolbarItem {
                        Button {
                            displayPreferences.toggle()
                        } label: {
                            Label("Preferences", systemImage: "gear")
                        }
                    }
                }
                .sheet(isPresented: $displayPreferences) {
                    NavigationStack {
                        AppPreferences()
                    }
                    .navigationTitle(Text("Preferences"))
                }
            #endif
        }
    }
}
