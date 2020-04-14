import Fluent
import Vapor

final class Todo: Model, Content {
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "name")
    var name: String
    
    init() { }

    init(id: UUID? = nil, title: String, name: String) {
        self.id = id
        self.title = title
        self.name = name
    }
}
