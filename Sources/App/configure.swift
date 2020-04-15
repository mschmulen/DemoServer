import Fluent
import FluentSQLiteDriver
import Vapor
//import JWT


//enum AuthorizationConfiguration {
//    case jwt
//    case simple
//    case none
//}
//
//let authConfig:AuthorizationConfiguration = .simple

extension String {
    var bytes: [UInt8] { .init(self.utf8) }
}

//extension JWKIdentifier {
//    static let `public` = JWKIdentifier(string: "public")
//    static let `private` = JWKIdentifier(string: "private")
//}

// Called before your application initializes.
public func configure(_ app: Application) throws {
    
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    
//    switch authConfig {
//    case .jwt:
//        let privateKey = try String(contentsOfFile: app.directory.workingDirectory + "jwtRS256.key")
//        let privateSigner = try JWTSigner.rs256(key: .private(pem: privateKey.bytes))
//
//        let publicKey = try String(contentsOfFile: app.directory.workingDirectory + "jwtRS256.key.pub")
//        let publicSigner = try JWTSigner.rs256(key: .public(pem: publicKey.bytes))
//
//        app.jwt.signers.use(privateSigner, kid: .private)
//        app.jwt.signers.use(publicSigner, kid: .public, isDefault: true)
//        break
//    case .simple:
//        //    app.middleware.use(TokenModel.authenticator().middleware())
//        //    app.middleware.use(UserBasicAuthenticator().middleware())
//        break
//    case .none:
//        break
//    }
    
    
    // Configure SQLite database
    app.databases.use(.sqlite(.memory), as: .sqlite)

    // Configure migrations
    app.migrations.add(CreateUser())
    app.migrations.add(CreateUserToken())
    app.migrations.add(CreateBoat())
    
    try app.autoMigrate().wait()
    
    try routes(app)
}
