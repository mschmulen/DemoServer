import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "email")
    var email: String
    
    @Field(key: "password")
    var password: String

    init() { }
    
    init(
        id: UUID? = nil,
        email: String,
        password: String
    ) {
        self.id = id
        self.email = email
        self.password = password
    }
}

extension User {
    struct UserSignUpRequest: Content {
        var email:String
        var password:String
    }
    
    struct UserSignInRequest: Content {
        var email: String
        var password: String
    }
    
    struct UserAuthResponse: Content {
        var email: String
        var reason:String
        var id: UUID?
        var sessionToken: String?
    }

    struct UserSignOutRequest: Content {
        var email:String
        var password:String
    }

    struct UserSignOutResponse: Content {
        var id:UUID
        var email:String
    }
    
    struct Output: Content {
        var id:UUID?
        var email:String
        var userType:String
    }
    
}
