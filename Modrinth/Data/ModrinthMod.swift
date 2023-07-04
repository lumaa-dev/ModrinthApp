
import Foundation

struct ModrinthMod: Codable, Identifiable {

  var id                   : String?    = nil
  var slug                 : String?    = nil
  var projectType          : String?    = nil
  var team                 : String?    = nil
  var title                : String?    = nil
  var description          : String?    = nil
  var body                 : String?    = nil
  var bodyUrl              : String?    = nil
  var donationUrls         : [DonationUrls]?    = []
  var published            : String?    = nil
  var updated              : String?    = nil
  var approved             : String?    = nil
  var queued               : String?    = nil
  var status               : String?    = nil
  var requestedStatus      : String?    = nil
  var moderatorMessage     : String?    = nil
  var license              : License?   = License()
  var clientSide           : String?    = nil
  var serverSide           : String?    = nil
  var downloads            : Int?       = nil
  var followers            : Int?       = nil
  var categories           : [String]?  = []
  var additionalCategories : [String]?  = []
  var gameVersions         : [String]?  = []
  var loaders              : [String]?  = []
  var versions             : [String]?  = []
  var iconUrl              : String?    = nil
  var issuesUrl            : String?    = nil
  var sourceUrl            : String?    = nil
  var wikiUrl              : String?    = nil
  var discordUrl           : String?    = nil
  var gallery              : [Gallery]? = []
  var flameAnvilProject    : String?    = nil
  var flameAnvilUser       : String?    = nil
  var color                : Int?       = nil

  enum CodingKeys: String, CodingKey {

    case id                   = "id"
    case slug                 = "slug"
    case projectType          = "project_type"
    case team                 = "team"
    case title                = "title"
    case description          = "description"
    case body                 = "body"
    case bodyUrl              = "body_url"
    case published            = "published"
    case updated              = "updated"
    case approved             = "approved"
    case queued               = "queued"
    case status               = "status"
    case requestedStatus      = "requested_status"
    case moderatorMessage     = "moderator_message"
    case license              = "license"
    case clientSide           = "client_side"
    case serverSide           = "server_side"
    case downloads            = "downloads"
    case followers            = "followers"
    case categories           = "categories"
    case additionalCategories = "additional_categories"
    case gameVersions         = "game_versions"
    case loaders              = "loaders"
    case versions             = "versions"
    case iconUrl              = "icon_url"
    case issuesUrl            = "issues_url"
    case sourceUrl            = "source_url"
    case wikiUrl              = "wiki_url"
    case discordUrl           = "discord_url"
    case donationUrls         = "donation_urls"
    case gallery              = "gallery"
    case flameAnvilProject    = "flame_anvil_project"
    case flameAnvilUser       = "flame_anvil_user"
    case color                = "color"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                   = try values.decodeIfPresent(String.self    , forKey: .id                   )
    slug                 = try values.decodeIfPresent(String.self    , forKey: .slug                 )
    projectType          = try values.decodeIfPresent(String.self    , forKey: .projectType          )
    team                 = try values.decodeIfPresent(String.self    , forKey: .team                 )
    title                = try values.decodeIfPresent(String.self    , forKey: .title                )
    description          = try values.decodeIfPresent(String.self    , forKey: .description          )
    body                 = try values.decodeIfPresent(String.self    , forKey: .body                 )
    bodyUrl              = try values.decodeIfPresent(String.self    , forKey: .bodyUrl              )
    donationUrls          = try values.decodeIfPresent([DonationUrls].self    , forKey: .donationUrls          )
    published            = try values.decodeIfPresent(String.self    , forKey: .published            )
    updated              = try values.decodeIfPresent(String.self    , forKey: .updated              )
    approved             = try values.decodeIfPresent(String.self    , forKey: .approved             )
    queued               = try values.decodeIfPresent(String.self    , forKey: .queued               )
    status               = try values.decodeIfPresent(String.self    , forKey: .status               )
    requestedStatus      = try values.decodeIfPresent(String.self    , forKey: .requestedStatus      )
    moderatorMessage     = try values.decodeIfPresent(String.self    , forKey: .moderatorMessage     )
    license              = try values.decodeIfPresent(License.self   , forKey: .license              )
    clientSide           = try values.decodeIfPresent(String.self    , forKey: .clientSide           )
    serverSide           = try values.decodeIfPresent(String.self    , forKey: .serverSide           )
    downloads            = try values.decodeIfPresent(Int.self       , forKey: .downloads            )
    followers            = try values.decodeIfPresent(Int.self       , forKey: .followers            )
    categories           = try values.decodeIfPresent([String].self  , forKey: .categories           )
    additionalCategories = try values.decodeIfPresent([String].self  , forKey: .additionalCategories )
    gameVersions         = try values.decodeIfPresent([String].self  , forKey: .gameVersions         )
    loaders              = try values.decodeIfPresent([String].self  , forKey: .loaders              )
    versions             = try values.decodeIfPresent([String].self  , forKey: .versions             )
    iconUrl              = try values.decodeIfPresent(String.self    , forKey: .iconUrl              )
    issuesUrl            = try values.decodeIfPresent(String.self    , forKey: .issuesUrl            )
    sourceUrl            = try values.decodeIfPresent(String.self    , forKey: .sourceUrl            )
    wikiUrl              = try values.decodeIfPresent(String.self    , forKey: .wikiUrl              )
    discordUrl           = try values.decodeIfPresent(String.self    , forKey: .discordUrl           )
    gallery              = try values.decodeIfPresent([Gallery].self , forKey: .gallery              )
    flameAnvilProject    = try values.decodeIfPresent(String.self    , forKey: .flameAnvilProject    )
    flameAnvilUser       = try values.decodeIfPresent(String.self    , forKey: .flameAnvilUser       )
    color                = try values.decodeIfPresent(Int.self       , forKey: .color                )
 
  }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.slug, forKey: .slug)
        try container.encodeIfPresent(self.projectType, forKey: .projectType)
        try container.encodeIfPresent(self.team, forKey: .team)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.body, forKey: .body)
        try container.encodeIfPresent(self.bodyUrl, forKey: .bodyUrl)
        try container.encodeIfPresent(self.donationUrls, forKey: .donationUrls)
        try container.encodeIfPresent(self.published, forKey: .published)
        try container.encodeIfPresent(self.updated, forKey: .updated)
        try container.encodeIfPresent(self.approved, forKey: .approved)
        try container.encodeIfPresent(self.queued, forKey: .queued)
        try container.encodeIfPresent(self.status, forKey: .status)
        try container.encodeIfPresent(self.requestedStatus, forKey: .requestedStatus)
        try container.encodeIfPresent(self.moderatorMessage, forKey: .moderatorMessage)
        try container.encodeIfPresent(self.license, forKey: .license)
        try container.encodeIfPresent(self.clientSide, forKey: .clientSide)
        try container.encodeIfPresent(self.serverSide, forKey: .serverSide)
        try container.encodeIfPresent(self.downloads, forKey: .downloads)
        try container.encodeIfPresent(self.followers, forKey: .followers)
        try container.encodeIfPresent(self.categories, forKey: .categories)
        try container.encodeIfPresent(self.additionalCategories, forKey: .additionalCategories)
        try container.encodeIfPresent(self.gameVersions, forKey: .gameVersions)
        try container.encodeIfPresent(self.loaders, forKey: .loaders)
        try container.encodeIfPresent(self.versions, forKey: .versions)
        try container.encodeIfPresent(self.iconUrl, forKey: .iconUrl)
        try container.encodeIfPresent(self.issuesUrl, forKey: .issuesUrl)
        try container.encodeIfPresent(self.sourceUrl, forKey: .sourceUrl)
        try container.encodeIfPresent(self.wikiUrl, forKey: .wikiUrl)
        try container.encodeIfPresent(self.discordUrl, forKey: .discordUrl)
        try container.encodeIfPresent(self.donationUrls, forKey: .donationUrls)
        try container.encodeIfPresent(self.gallery, forKey: .gallery)
        try container.encodeIfPresent(self.flameAnvilProject, forKey: .flameAnvilProject)
        try container.encodeIfPresent(self.flameAnvilUser, forKey: .flameAnvilUser)
        try container.encodeIfPresent(self.color, forKey: .color)
    }
    
  init() {

  }

}
