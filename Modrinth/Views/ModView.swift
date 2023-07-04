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

struct ModView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
