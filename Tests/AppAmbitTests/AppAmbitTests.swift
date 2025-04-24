import XCTest
@testable import AppAmbit

final class AppAmbitTests: XCTestCase {

    func testStoreConsumer() async {
        let expectation = self.expectation(description: "Token should be returned")
        let tester = Test()

        tester.storeConsumer { token in
            XCTAssertNotNil(token, "Token no debe ser nil")
            if let token = token {
                XCTAssertTrue(token.contains("|"), "El token debe contener '|'")
            }
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 10)
    }
    
    // Caso de prueba para startSession
     func testStartSession() async {
         let expectation = self.expectation(description: "Session should start successfully")
         let tester = Test()
         
         // 1. Primero obtenemos un token válido (usando storeConsumer)
         tester.storeConsumer { token in
             guard let token = token else {
                 XCTFail("No se pudo obtener el token para iniciar sesión")
                 expectation.fulfill()
                 return
             }
             
             // 2. Llamamos a startSession con el token recibido
             tester.startSession(token: token) { success in
                 XCTAssertTrue(success, "La sesión debería iniciarse correctamente")
                 expectation.fulfill()
             }
         }
         
         await fulfillment(of: [expectation], timeout: 10)
     }
}
