//Made by Lumaa

import SwiftUI

struct ListModView: View {
    let mod: Hits
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text(mod.title)
                    .font(.system(size: 20, design: .rounded))
                    .bold()
                    .lineLimit(1)
                
                Text(mod.description ?? "")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .lineLimit(3)
            }
            
            Spacer()
            
            VStack {
                HStack {
                    downloads
                }
            }
        }
        .padding(10)
        .contextMenu {
            ShareLink(item: URL(string: "https://modrinth.com/mod/\(mod.projectId ?? "backrooms")")!) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            
            Button {
                var recordedMods = loadRecords()
                let filtered = recordedMods.filter({ $0.id == mod.projectId })
                
                if (filtered.count < 1) {
                    requestMod(id: mod.projectId ?? "backrooms", completionHandler: { modrinthMod in
                        recordedMods.append(RecordedMod(id: mod.projectId ?? "backrooms", mod: modrinthMod, records: [Record(id: mod.projectId ?? "backrooms", date: .now, downloads: modrinthMod.downloads ?? 0, followers: modrinthMod.followers ?? 0)]))
                        
                        saveRecords(records: recordedMods)
                    })
                }
            } label: {
                Label("Add to the records", systemImage: "chart.line.uptrend.xyaxis")
            }
        }
    }
    
    var downloads: some View {
        VStack (alignment: .trailing) {
            HStack(spacing: 2) {
                Text("\(mod.downloads ?? 0)")
                    .font(.system(size: 10))
                    .lineLimit(1)
                
                Image(systemName: "square.and.arrow.down")
                    .font(.system(size: 10))
            }
            
            HStack(spacing: 2) {
                Text("\(mod.follows ?? 0)")
                    .font(.system(size: 10))
                    .lineLimit(1)
                
                Image(systemName: "heart")
                    .font(.system(size: 10))
            }
        }
    }
}
