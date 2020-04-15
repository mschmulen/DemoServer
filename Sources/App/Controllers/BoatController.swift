import Fluent
import Vapor

struct BoatController {
    
    // http://localhost:8080/boats?
//    func index(req: Request) throws -> EventLoopFuture<[Boat]> {
//        return Boat.query(on: req.db).all()
//    }
    
    // http://localhost:8080/boats?page=1&per=100
    func index(req: Request) throws -> EventLoopFuture<Page<Boat>> {
        return Boat.query(on: req.db)
            .paginate(for: req)
            .map{ page in
                page.map{
                    $0
                }
        }
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


extension BoatController {
    
    func update(req: Request) throws -> EventLoopFuture<Boat> {
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        let input = try req.content.decode(Boat.self)
        
        return Boat.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { model in
                model.title = input.title
                model.name = input.name
                model.length = input.length
                model.builder = input.builder
                //model.userID = input.userID
                model.price = input.price
                model.isFeatured = input.isFeatured
                return model.save(on: req.db).map { model }
        }
    }
    
    func show(req: Request) throws -> EventLoopFuture<Boat> {
        
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return Boat.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { $0 }
    }
}
