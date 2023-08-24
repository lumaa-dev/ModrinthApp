//Made by Lumaa

import SwiftUI

struct ListModView: View {
    let mod: Hits
    let size: CGSize
    let round: Bool = UserDefaults.standard.bool(forKey: "round")
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text(mod.title)
                    .font(.system(size: 20, design: .rounded))
                    .bold()
                    .lineLimit(1)
                    #if os(iOS)
                    .tint(Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.label))
                    #elseif os(macOS)
                    .tint(Color(nsColor: NSColor.labelColor))
                    .foregroundColor(Color(nsColor: NSColor.labelColor))
                    #endif
                
                Text(mod.description ?? "")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    #if os(iOS)
                    .tint(Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.label))
                    #elseif os(macOS)
                    .tint(Color(nsColor: NSColor.labelColor))
                    .foregroundColor(Color(nsColor: NSColor.labelColor))
                    #endif
            }
            
            Spacer()
            
            VStack {
                HStack {
                    downloads
                }
            }
        }
        .frame(width: size.width / 1.2, height: 50)
        .padding(10)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .contextMenu {
            ShareLink(item: URL(string: "https://modrinth.com/mod/\(mod.projectId ?? "backrooms")")!) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            
            Divider()
            
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
                Text("\(round ? mod.downloads?.roundedWithAbbreviations ?? "0" : mod.downloads?.toString ?? "0")")
                    .font(.caption)
                    .lineLimit(1)
                    #if os(iOS)
                    .tint(Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.label))
                    #elseif os(macOS)
                    .tint(Color(nsColor: NSColor.labelColor))
                    .foregroundColor(Color(nsColor: NSColor.labelColor))
                    #endif
                
                Image(systemName: "square.and.arrow.down")
                    .font(.caption)
                    #if os(iOS)
                    .tint(Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.label))
                    #elseif os(macOS)
                    .tint(Color(nsColor: NSColor.labelColor))
                    .foregroundColor(Color(nsColor: NSColor.labelColor))
                    #endif
            }
            
            HStack(spacing: 2) {
                Text("\(round ? mod.follows?.roundedWithAbbreviations ?? "0" : mod.follows?.toString ?? "0")")
                    .font(.caption)
                    .lineLimit(1)
                    #if os(iOS)
                    .tint(Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.label))
                    #elseif os(macOS)
                    .tint(Color(nsColor: NSColor.labelColor))
                    .foregroundColor(Color(nsColor: NSColor.labelColor))
                    #endif
                
                Image(systemName: "heart")
                    .font(.caption)
                    #if os(iOS)
                    .tint(Color(uiColor: UIColor.label))
                    .foregroundColor(Color(uiColor: UIColor.label))
                    #elseif os(macOS)
                    .tint(Color(nsColor: NSColor.labelColor))
                    .foregroundColor(Color(nsColor: NSColor.labelColor))
                    #endif
            }
        }
    }
}
