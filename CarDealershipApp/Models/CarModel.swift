import Foundation
import FirebaseFirestore

struct CarModel: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore document ID auto generates
    
    let photosURL: [String]
    let model: String
    let manufacturer: String
    let price: String
    let vehicleType: String
    let year: String
    let engineType: String
    let condition: String
    let userId: String

}
