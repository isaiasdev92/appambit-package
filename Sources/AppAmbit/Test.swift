import Foundation

public class Test {
    private let service = NetworkService()

    public init() {}

    public func storeConsumer(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://staging-appambit.com/api/consumer") else {
            completion(nil)
            return
        }

        let request = ConsumerRequest(
            app_key: "3552ae64-c9de-4a49-9445-86f0f6dddfcb",
            device_id: generateDeviceId(),
            device_model: "iPhone 18",
            user_id: "00008101-000E17360C8422AE",
            user_email: "jesusmarquez.mc@gmail.com",
            os: "iOS 18.1",
            country: "US",
            language: "en"
        )

        service.postData(to: url, body: request) { (result: Result<ConsumerResponse, Error>) in
            switch result {
            case .success(let response):
                completion(response.token)
            case .failure(let error):
                print("StoreConsumer error:", error)
                completion(nil)
            }
        }
    }

    public func startSession(token: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://staging-appambit.com/api/session/start") else {
            completion(false)
            return
        }

        let formatter = ISO8601DateFormatter()
        let now = formatter.string(from: Date())

        let request = SessionRequest(timestamp: now)

        service.postData(
            to: url,
            body: request,  	
            headers: [
                "Authorization": "Bearer \(token)"
            ]
        ) { (result: Result<SessionResponse, Error>) in
            switch result {
            case .success(let response):
                print("Sesión iniciada: ID \(response.session_id)")
                completion(true)
            case .failure(let error):
                print("StartSession error:", error)
                completion(false)
            }
        }
    }
    
    func generateDeviceId() -> String {
        func randomHex(_ length: Int) -> String {
            let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            return String((0..<length).map { _ in letters.randomElement()! })
        }

        let part1 = randomHex(8)
        let part2 = randomHex(16)

        return "\(part1)-\(part2)"
    }
}
