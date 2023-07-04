
import Foundation

struct License: Codable {

  var id   : String? = nil
  var name : String? = nil
  var url  : String? = nil

  enum CodingKeys: String, CodingKey {

    case id   = "id"
    case name = "name"
    case url  = "url"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id   = try values.decodeIfPresent(String.self , forKey: .id   )
    name = try values.decodeIfPresent(String.self , forKey: .name )
    url  = try values.decodeIfPresent(String.self , forKey: .url  )
 
  }

  init() {

  }

}