import Vapor
import Fluent
import Foundation

final class User: Model {
    var id: Node?
    var username: String
    var phone: String
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        username = try node.extract("username")
        phone = try node.extract("phone")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "username": username,
            "phone": phone
            ])
    }

}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("users") { (creator) in
            creator.id()
            creator.string("username")
            creator.string("phone")
        }
    }

    static func revert(_ database: Database) throws {
        //
    }
}
