//Made by Lumaa

import SwiftUI
import WebKit
import MarkdownUI

struct ModView: View {
    @State var md: String = ""
    @State var newCall: Bool = false
    
    let hitMod: Hits
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            ScrollView {
                Text(hitMod.title)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .padding()
                
                Text(hitMod.description ?? "No description.")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: size.width - 50)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Divider()
                
                VStack (alignment: .leading) {
                    Label("\(hitMod.downloads ?? 0) downloads", systemImage: "square.and.arrow.down")
                    
                    Label("\(hitMod.follows ?? 0) followers", systemImage: "heart")
                    
                    Text(envrionmentString(client: hitMod.clientSide ?? "unknown", server: hitMod.serverSide ?? "unknown"))
                }
                .frame(width: size.width - 50)
                .padding(10)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                if (newCall) {
                    Markdown(trimHtml(md).isEmpty ? "*No body was found*" : trimHtml(md))
                        .padding()
                } else {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                        .onAppear {
                            requestMod(id: hitMod.projectId ?? "backrooms", completionHandler: { mod in
                                md = mod.body ?? "*No body was found.*"
                                newCall = true
                            })
                        }
                }
            }
            .frame(minWidth: size.width, minHeight: size.height)
        }
    }
}

func envrionmentString(client: String, server: String) -> String {
    if (client == "required" && server == "required") {
        return "Client and server"
    } else if (client == "optional" && server == "optional") {
        return "Client or server"
    } else if (client == "unsupported" && server == "unsupported") {
        return "Unsupported"
    } else if ((client == "required" || client == "optional") && (server == "unsupported") || (server == "optional")) {
        return "Client"
    } else if ((server == "required" || server == "optional") && (client == "unsupported") || (client == "optional")) {
        return "Server"
    }
    return "Unidentified"
}

struct ModView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
