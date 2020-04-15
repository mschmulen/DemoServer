import Fluent

struct CreateBoat: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("boats")
            .id()
            .field("title", .string, .required)
            .field("name", .string, .required)
            .field("length", .float, .required)
            .field("builder", .string, .required)
            .field("price", .double, .required)
            .field("isFeatured", .bool, .required)
            .field("userReference", .uuid, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("boats").delete()
    }
}
