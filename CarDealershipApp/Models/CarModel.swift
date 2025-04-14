import Foundation
import FirebaseFirestore

struct CarModel: Identifiable, Codable {
    @DocumentID var id: String? 

    let photosURL: [String]
    let model: String
    let manufacturer: String
    let price: String
    let vehicleType: String
    let year: String
    let engineType: String
    let condition: String
    let userId: String

    
    var imageURL: String? {
        return photosURL.first
    }
}

extension CarModel {
    var wrappedId: String {
        id ?? UUID().uuidString
    }
}
