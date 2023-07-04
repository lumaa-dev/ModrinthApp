
import Foundation

struct Gallery: Codable {

  var url         : String? = nil
  var featured    : Bool?   = nil
  var title       : String? = nil
  var description : String? = nil
  var created     : String? = nil
  var ordering    : Int?    = nil

  enum CodingKeys: String, CodingKey {

    case url         = "url"
    case featured    = "featured"
    case title       = "title"
    case description = "description"
    case created     = "created"
    case ordering    = "ordering"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    url         = try values.decodeIfPresent(String.self , forKey: .url         )
    featured    = try values.decodeIfPresent(Bool.self   , forKey: .featured    )
    title       = try values.decodeIfPresent(String.self , forKey: .title       )
    description = try values.decodeIfPresent(String.self , forKey: .description )
    created     = try values.decodeIfPresent(String.self , forKey: .created     )
    ordering    = try values.decodeIfPresent(Int.self    , forKey: .ordering    )
 
  }

  init() {

  }

}