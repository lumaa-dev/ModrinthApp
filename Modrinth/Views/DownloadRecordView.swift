//Made by Lumaa

import SwiftUI
import Charts

struct DownloadRecordView: View {
    @State var recordedMod: RecordedMod
    @State var disabledRefresh: Bool = false
    @State var showSymbols: Bool = UserDefaults.standard.bool(forKey: "symbols")
    
    let typeCounts: [String] = ["Downloads", "Followers"]
    @State var addingCount: Bool = false
    @State var editsValues: Bool = false
    @State var showSettings: Bool = false
    @State var showProject: Bool = false
    @State var date: Date = Date.now
    @State var selectedCount: String = "Downloads"
    @State var number: String = ""
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                let size = geo.size
                
                VStack {
                    Text(recordedMod.mod.title ?? "Unknown Mod")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    //TODO: Display a list of buttons to fully take advantage of the data
                    
                    Spacer()
                    
                    RecordChart(recordedMod: recordedMod, showSymbols: showSymbols, size: size)
                    
                    Spacer()
                    
                    Button {
                        disabledRefresh = true
                        requestMod(id: recordedMod.mod.id!, completionHandler: { mod in
                            var recordedMods = loadRecords()
                            let i = recordedMods.firstIndex(where: { $0.id == recordedMod.id })
                            
                            var changeDls: Bool
                            var diffFlws: Bool
                            
                            if (recordedMod.records.filter({ $0.downloads != -1 }).count > 0) {
                                changeDls = mod.downloads ?? 0 >= recordedMod.records.filter({ $0.downloads != -1 }).sorted(by: { $0.date > $1.date })[0].downloads + (recordedMod.downloadTolerence?.rawValue ?? 1)
                            } else {
                                changeDls = true
                            }
                            
                            if (recordedMod.records.filter({ $0.followers != -1 }).count > 0) {
                                diffFlws = recordedMod.records.filter({ $0.followers != -1 })[0].followers == mod.followers!
                            } else {
                                diffFlws = false
                            }
                            
                            disabledRefresh = false
                            
                            if (!changeDls && diffFlws) { return }
                            
                            recordedMod.records.append(Record(id: recordedMod.id, date: .now, downloads: changeDls ? mod.downloads! : -1, followers: mod.followers!))
                            
                            recordedMod.records.sort(by: { $0.date > $1.date && $0.downloads > $1.downloads })
                            recordedMods[i!] = recordedMod
                            
                            saveRecords(records: recordedMods)
                        })
                    } label: {
                        Text("Update Statistics")
                            .bold()
                        #if os(iOS)
                            .foregroundColor(Color(uiColor: .label))
                        #endif
                            .padding()
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .disabled(disabledRefresh)
                    }
                    
                    Spacer()
                    
                    if (recordedMod.records.count >= 2) {
                        Text("+\(recordedMod.records[0].downloads - recordedMod.records[1].downloads) downloads!")
                            .foregroundColor(Color.green)
                    }
                    
                    //TODO: Monthly download graph (iOS 17)
                    // To do specficially for iOS 17 Swift Charts stuff yk what i mean future me
                }
            }
            .sheet(isPresented: $addingCount) {
                VStack {
                    Picker("", selection: $selectedCount) {
                        ForEach(typeCounts, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(5)
                    
                    DatePicker("", selection: $date, in: Date.distantPast...Date.now, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(.compact)
                    
                    TextField("715", text: $number)
                    #if os(iOS)
                        .keyboardType(.numberPad)
                    #endif
                        .padding()
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        var recordedMods = loadRecords()
                        let i = recordedMods.firstIndex(where: { $0.id == recordedMod.id })
                        
                        recordedMod.records.append(Record(id: recordedMod.id, date: date, downloads: selectedCount == typeCounts[0] ? Int(number)! : -1, followers: selectedCount == typeCounts[1] ? Int(number)! : -1))
                        
                        recordedMod.records.sort(by: { $0.date > $1.date && $0.downloads > $1.downloads })
                        recordedMods[i!] = recordedMod
                        
                        saveRecords(records: recordedMods)
                        
                    } label: {
                        Text("Add")
                            .bold()
                        #if os(iOS)
                            .foregroundColor(Color(uiColor: .label))
                        #endif
                            .padding()
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .presentationDetents([.height(250)])
                .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $editsValues) {
                NavigationStack {
                    EditValuesView(records: $recordedMod.records)
                }
            }
            .sheet(isPresented: $showSettings) {
                NavigationStack {
                    RecordModProperties(recordedMod: $recordedMod)
                        .navigationTitle(Text("Preferences"))
                    #if os(iOS)
                        .navigationBarTitleDisplayMode(.inline)
                    #endif
                }
            }
            .sheet(isPresented: $showProject) {
                NavigationStack {
                    //TODO: Request latest body of mod
                    RecordModView(mod: recordedMod.mod)
                }
                .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem {
                    Menu {
                        Button {
                            showSettings.toggle()
                        } label: {
                            Label("Preferences", systemImage: "gear")
                        }
                        
                        Button {
                            editsValues.toggle()
                        } label: {
                            Label("Edit Values", systemImage: "square.and.pencil")
                        }
                        
                        Divider()
                        
                        Button {
                            UserDefaults.standard.set(!UserDefaults.standard.bool(forKey: "symbols"), forKey: "symbols")
                            showSymbols = UserDefaults.standard.bool(forKey: "symbols")
                        } label: {
                            if (showSymbols) {
                                Label("Show symbols", systemImage: "checkmark")
                            } else {
                                Text("Show symbols")
                            }
                        }
                        
                        Button {
                            showProject.toggle()
                        } label: {
                            Label("Show project page", systemImage: "doc.text")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                
                ToolbarItem {
                    Button {
                        addingCount.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

private struct RecordChart: View {
    let recordedMod: RecordedMod
    let showSymbols: Bool
    let size: CGSize
    
    var body: some View {
        Chart {
            ForEach(recordedMod.records) { record in
                if (record.downloads > -1) {
                    if (showSymbols) {
                        LineMark(x: .value("Date", record.date), y: .value("Downloads", record.downloads))
                        .symbol(by: .value("Type", "Downloads"))
                            .annotation {
                                HStack {
                                    Text("\(record.downloads)")
                                        .padding(5)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .offset(y: -5)
                                }
                            }
                    } else {
                        LineMark(x: .value("Date", record.date), y: .value("Downloads", record.downloads))
                        .interpolationMethod(InterpolationMethod.monotone)
                        .foregroundStyle(by: .value("Type", "Downloads"))
                            .annotation {
                                HStack {
                                    Text("\(record.downloads)")
                                        .padding(5)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .offset(y: -5)
                                }
                            }
                    }
                }
                
                if (record.followers > -1) {
                    if (showSymbols) {
                        LineMark(x: .value("Date", record.date), y: .value("Followers", record.followers))
                            .symbol(by: .value("Type", "Followers"))
                            .annotation {
                                HStack {
                                    Text("\(record.followers)")
                                        .padding(5)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .offset(y: -5)
                                }
                            }
                    } else {
                        LineMark(x: .value("Date", record.date), y: .value("Followers", record.followers))
                            .interpolationMethod(InterpolationMethod.monotone)
                            .foregroundStyle(by: .value("Type", "Followers"))
                            .annotation {
                                HStack {
                                    Text("\(record.followers)")
                                        .padding(5)
                                        .background(Color.gray.opacity(0.3))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .offset(y: -5)
                                }
                            }
                    }
                    
                }
            }
        }
        .frame(width: size.width - 20, height: size.width - 20, alignment: .center)
        .padding()
    }
}
