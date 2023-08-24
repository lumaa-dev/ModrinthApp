//Made by Lumaa

import SwiftUI

struct EditValuesView: View {
    @Binding var records: [Record]
    
    var body: some View {
        List {
            ForEach(records, id: \.date) { rec in
                HStack {
                    VStack (alignment: .leading) {
                        Text("Downloads: \(rec.downloads < 1 ? 0 : rec.downloads)")
                        Text("Followers: \(rec.followers < 1 ? 0 : rec.followers)")
                    }
                    
                    Spacer()
                    
                    Text(rec.date.formatted())
                        .foregroundColor(.gray)
                        .opacity(0.3)
                }
            }
            .onDelete { indexOffsets in
                var recordedMods = loadRecords()
                let i = recordedMods.firstIndex(where: { $0.id == records[0].id })
                
                records.remove(atOffsets: indexOffsets)
                recordedMods[i!].records = records
                
                saveRecords(records: recordedMods)
            }
        }
        #if os(iOS)
        .navigationBarTitle(Text("Edit Values"))
        #else
        .navigationTitle(Text("Edit Values"))
        #endif
    }
}
