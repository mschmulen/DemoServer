import Fluent
import Vapor

struct TokenController {
    
    func index(req: Request) throws -> EventLoopFuture<[TokenModel]> {
        return TokenModel.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<TokenModel> {
        let model = try req.content.decode(TokenModel.self)
        return model.save(on: req.db).map { model }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return TokenModel.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
