//Made by Lumaa

import SwiftUI
#if os (iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct SearchView: View {
    @State var mods: [Hits] = []
    @State var filteredMods: [Hits] = []
    @State var totalHits: Int = 0
    @State var originalEnd: Bool = false
    
    @State var searchText: String = ""
    
    var body: some View {
        if (mods.count < 1 && originalEnd == false) {
            ProgressView()
                .progressViewStyle(.circular)
                .onAppear {
                    loadSearch(query: "", page: 1, completionHandler: { search in
                        totalHits = search.totalHits
                        mods = search.hits ?? []
                        filteredMods = mods
                        originalEnd = true
                    })
                }
        } else if (mods.count > 0) {
            GeometryReader { proxy in
                let size = proxy.size
                
                ScrollView {
                    VStack (alignment: .center) {
                        ForEach(filteredMods, id: \.projectId) { mod in
                            let openApp = UserDefaults.standard.bool(forKey: "inApp")
                            if openApp {
                                NavigationLink {
                                    ModView(hitMod: mod)
                                } label: {
                                    ListModView(mod: mod, size: size)
                                }
                                .buttonStyle(.plain)
                            } else {
                                Link(destination: URL(string: "https://modrinth.com/mod/\(mod.projectId ?? "backrooms")")!) {
                                    ListModView(mod: mod, size: size)
                                        #if os(iOS)
                                        .tint(Color(UIColor.label))
                                        #elseif os(macOS)
                                        .tint(Color(nsColor: NSColor.labelColor))
                                        #endif
                                }
                            }
                        }
                        
                        Text("\(filteredMods.count) mods")
                            .padding()
                            .foregroundColor(Color.gray)
                            .font(.caption)
                    }
                }
                #if os(macOS)
                .frame(width: size.width / 1.75, alignment: .center)
                .offset(x: 200)
                #endif
                
                #if os(iOS)
                .frame(width: size.width)
                #endif
                .searchable(text: $searchText, placement: .toolbar, prompt: "Search for mods...")
            }
            .navigationTitle(Text("Mods"))
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: searchText) { newString in
                if (newString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                    loadSearch(query: searchText, page: 1, completionHandler: { search in
                        totalHits = search.totalHits
                        mods = search.hits ?? []
                        filteredMods = mods
                    })
                } else {
                    filteredMods = mods.filter({ $0.title.localizedCaseInsensitiveContains(newString) })
                }
            }
            .onSubmit(of: .search) {
                loadSearch(query: searchText, page: 1, completionHandler: { search in
                    totalHits = search.totalHits
                    mods = search.hits ?? []
                    filteredMods = mods
                })
            }
        } else {
            ScrollView {
                Text("Oh!\nSeems like your search got 0 results...")
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.top, 50)
            }
            .navigationTitle(Text("Mods"))
            .searchable(text: $searchText, placement: .toolbar, prompt: "Search for mods...")
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: searchText) { newString in
                if (newString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                    loadSearch(query: searchText, page: 1, completionHandler: { search in
                        totalHits = search.totalHits
                        mods = search.hits ?? []
                        filteredMods = mods
                    })
                } else {
                    filteredMods = mods.filter({ $0.title.localizedCaseInsensitiveContains(newString) })
                }
            }
            .onSubmit(of: .search) {
                loadSearch(query: searchText, page: 1, completionHandler: { search in
                    totalHits = search.totalHits
                    mods = search.hits ?? []
                    filteredMods = mods
                })
            }
        }
    }
}
