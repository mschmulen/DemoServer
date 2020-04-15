import Fluent
import Vapor

final class TokenModel: Model, Content {
    
    static let schema = "tokens"

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "value")
    var value: String
    
    @Parent(key: "userReference")
    var userReference: UserModel
    
    init() { }
    
    init(
        id: UUID? = nil,
        value: String,
        userReference: UUID
    )
    {
        self.id = id
        self.value = value
        self.$userReference.id = userReference
    }
    
}

//extension TokenModel: ModelAuthenticatable {
//    
//    static var usernameKey: KeyPath<TokenModel, Field<String>> {
//        <#code#>
//    }
//    
//    static var passwordHashKey: KeyPath<TokenModel, Field<String>> {
//        <#code#>
//    }
//    
//    func verify(password: String) throws -> Bool {
//        <#code#>
//    }
//    
//    
//    static let valueKey = \TokenModel.$value
//    //static let userKey = \TokenModel.$userID
//    static let userKey = \TokenModel.$userReference
//    
//    var isValid: Bool {
//        print("is valid ")
//        return true // you can check expiration or anything else...
//    }
//}
