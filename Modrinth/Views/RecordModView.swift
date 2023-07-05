//Made by Lumaa

import SwiftUI
import WebKit
import MarkdownUI

// Usage will be removed in the future
struct RecordModView: View {
    let mod: ModrinthMod
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            ScrollView {
                Text(mod.title ?? "Unknown Mod")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .padding()
                
                Text(mod.description ?? "No description.")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: size.width - 50)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Markdown(trimHtml(mod.body ?? "Unknown Body").isEmpty ? "*No body was found*" : trimHtml(mod.body ?? "Unknown Body"))
                    .padding()
            }
            .frame(minWidth: size.width, minHeight: size.height)
        }
    }
}

struct RecordModView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadRecordsView()
    }
}
