//Made by Lumaa

import SwiftUI

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
            List(filteredMods, id: \.projectId) { mod in
                NavigationLink {
                    ModView(hitMod: mod)
                } label: {
                    ListModView(mod: mod)
                }
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
        } else {
            ScrollView {
                Text("Oh! Seems like your search got 0 results...")
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
