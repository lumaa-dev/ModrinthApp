//Made by Lumaa

import SwiftUI

struct DownloadRecordsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var recordedMods: [RecordedMod] = []
    
    //MARK: - Adding Mod Vars
    @State var addingMod: Bool = false
    @State var modId: String = ""
    
    var body: some View {
        ZStack {
            if recordedMods.count < 1 {
                HStack {
                    Text("Tap on the")
                    Image(systemName: "plus.circle")
                        .foregroundColor(.accentColor)
                    Text("on the top right to add a mod")
                }
                .onAppear {
                    recordedMods = loadRecords()
                }
                .sheet(isPresented: $addingMod) {
                    ZStack {
                        TextField("backrooms", text: $modId)
                            .autocorrectionDisabled(true)
                            .disableAutocorrection(true)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.search)
                            .onSubmit {
                                DispatchQueue.main.async {
                                    requestMod(id: modId, completionHandler: { mod in
                                        recordedMods.append(RecordedMod(id: mod.id ?? "", mod: mod, downloadTolerence: DownloadTolerance.none, records: [Record(id: mod.id ?? "", date: Date.now, downloads: mod.downloads ?? 0, followers: mod.followers ?? 0)]))
                                        
                                        saveRecords(records: recordedMods)
                                    })
                                }
                            }
                    }
                    .presentationDetents([.height(150)])
                    .presentationDragIndicator(.hidden)
                    
                }
            } else {
                List {
                    Section(header: Text("Mods")) {
                        ForEach(recordedMods) { record in
                            NavigationLink {
                                DownloadRecordView(recordedMod: record)
                            } label: {
                                Text(record.mod.title ?? "Unknown Title")
                            }
                        }
                        .onMove { fromIndex, toIndex in
                            recordedMods.move(fromOffsets: fromIndex, toOffset: toIndex)
                            
                            saveRecords(records: recordedMods)
                        }
                        .onDelete { i in
                            recordedMods.remove(atOffsets: i)
                            
                            saveRecords(records: recordedMods)
                        }
                    }
                    
                    Section(header: Text("Lists")) {
                        // soon
                    }
                }
                .sheet(isPresented: $addingMod) {
                    ZStack {
                        TextField("backrooms", text: $modId)
                            .autocorrectionDisabled(true)
                            .disableAutocorrection(true)
                            .padding()
                            .textFieldStyle(.roundedBorder)
                            .submitLabel(.search)
                            .onSubmit {
                                if (recordedMods.contains(where: { $0.mod.slug == modId || $0.mod.id == modId})) {
                                    return
                                }
                                
                                DispatchQueue.main.async {
                                    requestMod(id: modId, completionHandler: { mod in
                                        recordedMods.append(RecordedMod(id: mod.id ?? "", mod: mod, downloadTolerence: DownloadTolerance.none, records: [Record(id: mod.id ?? "", date: Date.now, downloads: mod.downloads ?? 0, followers: mod.followers ?? 0)]))
                                        
                                        saveRecords(records: recordedMods)
                                    })
                                }
                            }
                    }
                    .presentationDetents([.height(150)])
                    .presentationDragIndicator(.hidden)
                    
                }
                .onAppear {
                    recordedMods = loadRecords()
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    addingMod.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
        }
    }
}

/*
 if (recordedMods.filter { record in
     record.id == mod.id
 }[0].id == mod.id) {
     return
 }
 */
