//Made by Lumaa

import Foundation

struct ModrinthSearch: Codable {

  var hits      : [Hits]? = []
  var offset    : Int    = 0
  var limit     : Int    = 0
  var totalHits : Int    = 0

  enum CodingKeys: String, CodingKey {

    case hits      = "hits"
    case offset    = "offset"
    case limit     = "limit"
    case totalHits = "total_hits"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    hits      = try values.decodeIfPresent([Hits].self , forKey: .hits      )
    offset    = try values.decode(Int.self    , forKey: .offset    )
    limit     = try values.decode(Int.self    , forKey: .limit     )
    totalHits = try values.decode(Int.self    , forKey: .totalHits )
 
  }

  init() {

  }

}

struct Hits: Codable, Hashable {

  var projectId         : String?   = nil
  var projectType       : String?   = nil
  var slug              : String?   = nil
  var author            : String?   = nil
  var title             : String   = ""
  var description       : String?   = nil
  var categories        : [String]? = []
  var displayCategories : [String]? = []
  var versions          : [String]? = []
  var downloads         : Int?      = nil
  var follows           : Int?      = nil
  var iconUrl           : String?   = nil
  var dateCreated       : String?   = nil
  var dateModified      : String?   = nil
  var latestVersion     : String?   = nil
  var license           : String?   = nil
  var clientSide        : String?   = nil
  var serverSide        : String?   = nil
  var gallery           : [String]? = []
  var featuredGallery   : String?   = nil
  var color             : Int?      = nil

  enum CodingKeys: String, CodingKey {

    case projectId         = "project_id"
    case projectType       = "project_type"
    case slug              = "slug"
    case author            = "author"
    case title             = "title"
    case description       = "description"
    case categories        = "categories"
    case displayCategories = "display_categories"
    case versions          = "versions"
    case downloads         = "downloads"
    case follows           = "follows"
    case iconUrl           = "icon_url"
    case dateCreated       = "date_created"
    case dateModified      = "date_modified"
    case latestVersion     = "latest_version"
    case license           = "license"
    case clientSide        = "client_side"
    case serverSide        = "server_side"
    case gallery           = "gallery"
    case featuredGallery   = "featured_gallery"
    case color             = "color"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    projectId         = try values.decodeIfPresent(String.self   , forKey: .projectId         )
    projectType       = try values.decodeIfPresent(String.self   , forKey: .projectType       )
    slug              = try values.decodeIfPresent(String.self   , forKey: .slug              )
    author            = try values.decodeIfPresent(String.self   , forKey: .author            )
    title             = try values.decode(String.self   , forKey: .title             )
    description       = try values.decodeIfPresent(String.self   , forKey: .description       )
    categories        = try values.decodeIfPresent([String].self , forKey: .categories        )
    displayCategories = try values.decodeIfPresent([String].self , forKey: .displayCategories )
    versions          = try values.decodeIfPresent([String].self , forKey: .versions          )
    downloads         = try values.decodeIfPresent(Int.self      , forKey: .downloads         )
    follows           = try values.decodeIfPresent(Int.self      , forKey: .follows           )
    iconUrl           = try values.decodeIfPresent(String.self   , forKey: .iconUrl           )
    dateCreated       = try values.decodeIfPresent(String.self   , forKey: .dateCreated       )
    dateModified      = try values.decodeIfPresent(String.self   , forKey: .dateModified      )
    latestVersion     = try values.decodeIfPresent(String.self   , forKey: .latestVersion     )
    license           = try values.decodeIfPresent(String.self   , forKey: .license           )
    clientSide        = try values.decodeIfPresent(String.self   , forKey: .clientSide        )
    serverSide        = try values.decodeIfPresent(String.self   , forKey: .serverSide        )
    gallery           = try values.decodeIfPresent([String].self , forKey: .gallery           )
    featuredGallery   = try values.decodeIfPresent(String.self   , forKey: .featuredGallery   )
    color             = try values.decodeIfPresent(Int.self      , forKey: .color             )
 
  }

  init() {

  }

}
