public struct ConsumerRequest: Codable {
    public let app_key: String
    public let device_id: String
    public let device_model: String
    public let user_id: String
    public let user_email: String
    public let os: String
    public let country: String
    public let language: String

    public init(app_key: String, device_id: String, device_model: String, user_id: String, user_email: String, os: String, country: String, language: String) {
        self.app_key = app_key
        self.device_id = device_id
        self.device_model = device_model
        self.user_id = user_id
        self.user_email = user_email
        self.os = os
        self.country = country
        self.language = language
    }
}
