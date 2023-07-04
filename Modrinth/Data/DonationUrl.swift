//Made by Lumaa

import Foundation

struct DonationUrls: Codable {

  var id       : String? = nil
  var platform : String? = nil
  var url      : String? = nil

  enum CodingKeys: String, CodingKey {

    case id       = "id"
    case platform = "platform"
    case url      = "url"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id       = try values.decodeIfPresent(String.self , forKey: .id       )
    platform = try values.decodeIfPresent(String.self , forKey: .platform )
    url      = try values.decodeIfPresent(String.self , forKey: .url      )
 
  }

  init() {

  }

}
