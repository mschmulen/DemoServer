import Fluent
import Vapor

final class Boat: Model, Content {
    static let schema = "boats"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "length")
    var length: Float

    @Field(key: "builder")
    var builder: String
    
    init() { }
    
    init(
        id: UUID? = nil,
        title: String,
        name: String,
        length: Float,
        builder: String
    ) {
        self.id = id
        self.title = title
        self.name = name
        self.length = length
        self.builder = builder
    }
}
