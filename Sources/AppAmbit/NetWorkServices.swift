import Foundation

public class NetworkService {
    public init() {}

    public func postData<T: Decodable, U: Encodable>(
        to url: URL,
        body: U,
        headers: [String: String] = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        do {
            if let jsonBody = try? JSONEncoder().encode(body),
               let jsonString = String(data: jsonBody, encoding: .utf8) {
                print("Enviando JSON:")
                print(jsonString)
                request.httpBody = jsonBody
            }
            
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
                return
            }

            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
