public struct SessionResponse: Codable {
    public let session_id: Int
    public let consumer_id: Int
    public let started_at: String
    public let end_at: String?
}
