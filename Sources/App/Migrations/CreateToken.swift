import Fluent

struct CreateUserToken: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tokens")
            .id()
            //.field("userID", .uuid, .references("users", "id"))
            .field("userReference", .uuid, .references("users", "id"))
            .field("value", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("tokens").delete()
    }
}
