//Made by Lumaa

import Foundation

func requestMod(id: String, completionHandler: @escaping (_ mod: ModrinthMod) -> Void) {
    var request = URLRequest(url: URL(string: "https://api.modrinth.com/v2/project/" + id)!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    
    let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
        guard let data = data else {
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let mod = try decoder.decode(ModrinthMod.self, from: data)
            completionHandler(mod)
            return
        } catch {
            print("Unable to Decode (\(error))")
        }
    })

    task.resume()
}

func loadSearch(query: String, page: Int, completionHandler: @escaping (_ output: ModrinthSearch) -> Void) {
    var request = URLRequest(url: URL(string: "https://api.modrinth.com/v2/search?query=\(query.trimmingCharacters(in: .whitespacesAndNewlines))&limit=100&offset=\((page - 1) * 100)")!, timeoutInterval: Double.infinity)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let search = try decoder.decode(ModrinthSearch.self, from: data)
            completionHandler(search)
            return
        } catch {
            print("Unable to Decode (\(error))")
        }
    }

    task.resume()
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

func trimHtml(_ string: String) -> String {
    var newString = string
    let matches = matches(for: "<.+>", in: string)
    
    for match in matches {
        newString = newString.replacingOccurrences(of: match, with: "")
    }
    
    return newString
}

func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

func replace(string: String, with: NSRegularExpression, to: String) {
    var s = string
    let mString = NSMutableString(string: string)
    with.replaceMatches(in: mString, options: [], range: NSMakeRange(0, mString.length), withTemplate: "")
    s = String(mString)
    s = s.replacingOccurrences(of: "  ", with: " ")
}
