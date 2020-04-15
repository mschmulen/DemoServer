import Fluent
import Vapor

final class UserModel: Model, Content {
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

extension UserModel {
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

//extension UserModel: Authenticatable {}
//
//struct UserModelFragmentAuthenticator: RequestAuthenticator {
//
//    typealias User = UserModel
//
//    func authenticate(request: Request) -> EventLoopFuture<Void> {
//        return User.find(UUID(uuidString: request.url.fragment ?? ""), on: request.db)
//    }
//
//    func authenticate(request: Request) -> EventLoopFuture<User?> {
//        return User.find(UUID(uuidString: request.url.fragment ?? ""), on: request.db)
//    }
//}


//
//// reference https://theswiftdev.com/all-about-authentication-in-vapor-4/
//
//extension UserModel: Authenticatable {}
//
//struct UserModelFragmentAuthenticator: RequestAuthenticator {
//    typealias User = UserModel
//
//    func authenticate(request: Request) -> EventLoopFuture<User?> {
//        return User.find(UUID(uuidString: request.url.fragment ?? ""), on: request.db)
//    }
//}
//
//
//
//
//struct UserModelBasicAuthenticator: BasicAuthenticator {
//    typealias User = UserModel
//
//    func authenticate(basic: BasicAuthorization, for request: Request) -> EventLoopFuture<User?> {
//        User.query(on: request.db)
//            .filter(\.$email == basic.username)
//            .first()
//            .flatMapThrowing {
//                guard let user = $0 else {
//                    return nil
//                }
//                guard try Bcrypt.verify(basic.password, created: user.password) else {
//                    return nil
//                }
//                return user
//            }
//   }
//}
//
//
//extension UserModel: ModelUser {
//    static let usernameKey = \UserModel.$email
//    static let passwordHashKey = \UserModel.$password
//
//    func verify(password: String) throws -> Bool {
//        try Bcrypt.verify(password, created: self.password)
//    }
//}
//
//// usage
//UserModel.authenticator().middleware()

//struct UserModelBearerAuthenticator: BearerAuthenticator {
//    
//    typealias User = UserModel
//
//   func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<UserModel?> {
//        // perform auth using the bearer.token value here...
//   }
//}
