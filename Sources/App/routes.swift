import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }
    
    app.get("hello") { req in
        return "Hello, world!"
    }
    
    let boatController = BoatController()
    app.get("boats", use: boatController.index)
    app.post("boats", use: boatController.create)
    app.on(.DELETE, "boats", ":id", use: boatController.delete)
    
    
    let userController = UserController()
    app.get("users", use: userController.index)
    app.post("users", use: userController.create)
    app.on(.DELETE, "users", ":id", use: userController.delete)
    
}
