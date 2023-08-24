//Made by Lumaa

import SwiftUI

struct AppPreferences: View {
    @Environment(\.dismiss) var dismiss
    
    @State var token = ""
    @State var round: RoundCounts = .noRounds
    @State var openIn: BodyType = .inApp
    
    var body: some View {
        Form {
            Section {
                TextField("Modrinth Token", text: $token)
                    .textFieldStyle(.squareBorder)
            }
            
            Section {
                Picker("Round counters", selection: $round) {
                    ForEach(RoundCounts.allCases, id: \.self) { count in
                        Text("\(count.rawValue)")
                    }
                }
                Picker("Open project", selection: $openIn) {
                    ForEach(BodyType.allCases, id: \.self) { type in
                        Text("\(textBody(type))")
                    }
                }
            }
        }
        .onAppear {
            token = UserDefaults.standard.string(forKey: "modrinthToken") ?? ""
            round = UserDefaults.standard.bool(forKey: "round") ? .thousand : .noRounds
            openIn = UserDefaults.standard.bool(forKey: "inApp") ? .inApp : .openWeb
        }
        .formStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Apply") {
                    UserDefaults.standard.set(token.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "modrinthToken")
                    UserDefaults.standard.set(round == .thousand, forKey: "round")
                    UserDefaults.standard.set(openIn == .inApp, forKey: "inApp")
                    
                    dismiss()
                }
            }
        }
    }
    
    func textBody(_ type: BodyType) -> String {
        switch (type) {
            case .inApp:
                return "In app"
                
//            case .inAppBrowser:
//                return "In-App Browser"
                
            case .openWeb:
                return "In browser"
        }
    }
}

struct AppPreferences_Previews: PreviewProvider {
    static var previews: some View {
        AppPreferences()
    }
}

enum RoundCounts: String, CaseIterable {
    case noRounds = "1000"
    case thousand = "1.0K"
}

enum BodyType: CaseIterable {
    case inApp
//    case inAppBrowser
    case openWeb
}
