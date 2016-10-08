import Vapor
import VaporSQLite

let drop = Droplet(preparations: [Post.self], providers: [VaporSQLite.Provider.self])

drop.get { req in
    let lang = req.headers["Accept-Language"]?.string ?? "en"
    return try drop.view.make("welcome", [
    	"message": Node.string(drop.localization[lang, "welcome", "title"])
    ])
}

drop.resource("posts", PostController())

drop.run()
