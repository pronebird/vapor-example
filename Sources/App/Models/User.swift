import Vapor
import Fluent
import Foundation

final class User: Model {
    var id: Node?
    var username: String
    var phone: String
    var longitude: Double?
    var latitude: Double?
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        username = try node.extract("username")
        phone = try node.extract("phone")
        longitude = try? node.extract("longitude")
        latitude = try? node.extract("latitude")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "username": username,
            "phone": phone,
            "longitude": longitude,
            "latitude": latitude
            ])
    }

}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(entity) { (creator) in
            creator.id()
            creator.string("username")
            creator.string("phone")
            creator.double("longitude", optional: true)
            creator.double("latitude", optional: true)
        }
    }

    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
}
