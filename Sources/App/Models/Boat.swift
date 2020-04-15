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
    
    @Field(key: "price")
    var price: Double

    @Field(key: "isFeatured")
    var isFeatured: Bool
    
    @Parent(key: "userReference")
    var userReference: UserModel
    
    init() { }
    
    init(
        id: UUID? = nil,
        title: String,
        name: String,
        length: Float,
        builder: String,
        price: Double,
        isFeatured: Bool,
        userReference: UUID
    ) {
        self.id = id
        self.title = title
        self.name = name
        self.length = length
        self.builder = builder
        self.price = price
        self.isFeatured = isFeatured
        self.$userReference.id = userReference
    }
}

