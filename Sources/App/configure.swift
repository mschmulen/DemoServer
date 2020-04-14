import Fluent
import FluentSQLiteDriver
import Vapor

// Called before your application initializes.
public func configure(_ app: Application) throws {
    // Serves files from `Public/` directory
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure SQLite database
    app.databases.use(.sqlite(.memory), as: .sqlite)

    // Configure migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateBoat())
    
    try app.autoMigrate().wait()
    
    try routes(app)
}
