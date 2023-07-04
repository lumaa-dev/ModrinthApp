//Made by Lumaa

import SwiftUI

struct RecordModProperties: View {
    @Binding var recordedMod: RecordedMod
    
    @State var dlTolerence: Int = DownloadTolerance.none.rawValue
    
    var body: some View {
        Form {
            Section(header: Text("Download Tolerence"), footer: Text("Download Tolerence prevents adding low changes to the downloads data\n\nThe current Download Tolerence will add only \(dlTolerence) downloads by \(dlTolerence) downloads")) {
                Picker("Download Tolerence", selection: $dlTolerence) {
                    ForEach(DownloadTolerance.allCases, id: \.rawValue) { tolerence in
                        switch tolerence {
                            case .none:
                                Text("None")
                            
                            case .low:
                                Text("Low")
                            
                            case .medium:
                                Text("Medium")
                                
                            case .high:
                                Text("High")
                            
                            case .massive:
                                Text("Massive")
                            
                            case .extreme:
                                Text("Extreme")
                        }
                    }
                }
                .onChange(of: dlTolerence) { new in
                    var recordedMods: [RecordedMod] = loadRecords()
                    let i = recordedMods.firstIndex(where: { $0.id == recordedMod.id })
                    
                    recordedMod.downloadTolerence = intToDlTolerence(dlTolerence)
                    recordedMods[i!] = recordedMod
                    
                    saveRecords(records: recordedMods)
                }
            }
            
            Section(header: Text("Lists")) {
                Text("*None*")
                    .foregroundColor(.gray.opacity(0.3))
            }
        }
        .onAppear {
            dlTolerence = recordedMod.downloadTolerence?.rawValue ?? DownloadTolerance.none.rawValue
        }
    }
}

func intToDlTolerence(_ int: Int) -> DownloadTolerance {
    switch int {
        case 1:
            return .none
            
        case 5:
            return .low
            
        case 10:
            return .medium
            
        case 25:
            return .high
            
        case 50:
            return .massive
            
        case 100:
            return .extreme
            
        default:
            return .none
    }
}
