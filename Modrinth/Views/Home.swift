//Made by Lumaa

import SwiftUI

struct Home: View {
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            NavigationStack {
                ScrollView(.vertical) {
                    VStack {
                        HStack {
                            Image("Mark")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 32)
                            Text("Modrinth")
                                .font(.largeTitle.bold())
                                .foregroundColor(.accentColor)
                        }
                        
                        Text("The place for Minecraft mods")
                            .frame(width: size.width)
                    }
                    .padding(50)
                    
                    VStack {
                        HStack {
                            NavigationLink {
                                SearchView()
                            } label: {
                                Text("Discover mods")
                                    .bold()
                                    .foregroundColor(Color(uiColor: .label))
                                    .padding()
                                    .background(Color.accentColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            
                            NavigationLink {
                                AboutView()
                            } label: {
                                Text("About")
                                    .foregroundColor(Color(uiColor: .label))
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .label), lineWidth: 0.5))
                            }
                        }
                        
                        HStack {
                            NavigationLink {
                                DownloadRecordsView()
                            } label: {
                                Text("Download Records")
                                    .bold()
                                    .foregroundColor(Color(uiColor: .label))
                                    .padding()
                                    .background(Color.accentColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                }
            }
            .frame(width: size.width, height: size.height)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
