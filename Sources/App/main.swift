import Vapor
import VaporPostgreSQL

let drop = Droplet(preparations: [Post.self, User.self], providers: [VaporPostgreSQL.Provider.self])

drop.get { req in
    let lang = req.headers["Accept-Language"]?.string ?? "en"
    return try drop.view.make("welcome", [
    	"message": Node.string(drop.localization[lang, "welcome", "title"])
    ])
}

let posts = PostController()

drop.resource("posts", PostController())

drop.run()
