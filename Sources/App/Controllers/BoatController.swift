import Fluent
import Vapor

struct BoatController {
    
    func index(req: Request) throws -> EventLoopFuture<[Boat]> {
        return Boat.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Boat> {
        let model = try req.content.decode(Boat.self)
        return model.save(on: req.db).map { model }
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Boat.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .map { .ok }
    }
}
