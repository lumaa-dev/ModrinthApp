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
                                #if os(iOS)
                                    .foregroundColor(Color(uiColor: .label))
                                    .padding()
                                    .background(Color.accentColor)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                #endif
                            }
                            
                            #if os(iOS)
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
                            #endif
                        }
                        
                        #if os(iOS)
                        NavigationLink {
                            ZStack {
                                Text("This app has been conceived for iPhones and Macs using iOS 16 or more\nNot related to Modrinth in any way.\n\nThis app was made in SwiftUI by Lumaa. Find out more on https://lumaa.fr/")
                                    .padding()
                                    .background(.gray.opacity(0.2))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .padding(10)
                            }
                        } label: {
                            Text("About")
                            
                                .foregroundColor(Color(uiColor: .label))
                            
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                         
                                    .stroke(Color(uiColor: .label), lineWidth: 0.5))
                        }
                        #endif
                    }
                    
                    //TODO: Like Modrinth home, display projects
                    //TODO: Display features only on Modrinth App
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
