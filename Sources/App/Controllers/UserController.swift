import Fluent
import Vapor

struct UserController {
    
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
