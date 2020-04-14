import Fluent
import Vapor

struct UserController {
    
    static let sessionToken = "SOME_TEMP_SESSION_TOKEN"
    
    func index(req: Request) throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<User> {
        let model = try req.content.decode(User.self)
        return model.save(on: req.db).map { model }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return User.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}

extension UserController {
    
    func update(req: Request) throws -> EventLoopFuture<User> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(User.self)
        
        return User.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { model in
                model.email = input.email
                return model.save(on: req.db).map { model }
        }
    }
    
    func show(req: Request) throws -> EventLoopFuture<User> {
        
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return User.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { $0 }
    }
}


// MARK: - Authenticaton routes
extension UserController {
    
    func signUp(req: Request) throws -> EventLoopFuture<User.UserAuthResponse> {
        let model = try req.content.decode(User.UserSignUpRequest.self)
        let newUser = User(
            email: model.email,
            password: model.password
        )
        return newUser.save(on: req.db).map {
            User.UserAuthResponse(
                email: newUser.email,
                reason: "valid",
                id: newUser.id,
                sessionToken: UserController.sessionToken
            )
        }
    }
    
    // httpMethod:GET This takes the ID parameter and gets the Boat based on the ID.
    func show( req: Request) throws -> EventLoopFuture<User.Output> {
        
        guard let id = req.parameters.get("appuserID", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return User.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map {
                User.Output(
                    id: $0.id,
                    email: $0.email,
                    userType: "unknown"
                )
        }
    }
    
    func signIn(req: Request) throws -> EventLoopFuture<User.UserAuthResponse> {
        let signInRequestModel = try req.content.decode(User.UserSignInRequest.self)
        
        return User.query(on: req.db)
            .filter(\User.$email == signInRequestModel.email)
            .first()
            .unwrap(or: Abort(.notFound))
            .map {
                
                // MAS TODO use Bcrypt has to verify this
                if signInRequestModel.password == $0.password {
                    return User.UserAuthResponse(
                        email: $0.email,
                        reason: "valid",
                        id: $0.id!,
                        sessionToken: UserController.sessionToken
                    )
                } else {
                    return User.UserAuthResponse(
                        email: $0.email,
                        reason: "invalid credentials",
                        id: $0.id,
                        sessionToken: nil
                    )
                }
        }
    }
    
    
//    func signOut(req: Request) throws -> EventLoopFuture<HTTPStatus> {
//
//        return User.find(req.parameters.get("id"), on: req.db)
//            .unwrap(or: Abort(.notFound))
//            .flatMap{ $0.update(on: req.db) }
//            .map { .ok }
//    }
    
}
