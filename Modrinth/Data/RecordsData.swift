//Made by Lumaa

import Foundation

struct RecordedMod: Codable, Identifiable {
    let id: String
    let mod: ModrinthMod
    var downloadTolerence: DownloadTolerance?
    var records: [Record]
}

struct Record: Codable, Identifiable {
    let id: String
    let date: Date
    let downloads: Int
    let followers: Int
}

struct RecordedList: Codable, Identifiable {
    let id: String
    let name: String
    let icon: String
    let smart: Bool
    let rmIds: [String] // recordedMods Ids
}

enum DownloadTolerance: Int, Codable, CaseIterable {
    case none = 1
    case low = 5
    case medium = 10
    case high = 25
    case massive = 50
    case extreme = 100
}

func saveRecords(records: [RecordedMod]) {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(records)
        UserDefaults.standard.set(data, forKey: "records")
    } catch {
        print("Unable to Encode Array of Records (\(error))")
    }
}

func loadRecords() -> [RecordedMod] {
    if let data = UserDefaults.standard.data(forKey: "records") {
        do {
            let decoder = JSONDecoder()
            let records = try decoder.decode([RecordedMod].self, from: data)
            return records
        } catch {
            print("Unable to Decode Records (\(error))")
            return []
        }
    } else {
        return []
    }
}
