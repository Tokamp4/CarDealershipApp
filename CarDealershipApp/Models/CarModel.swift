import Foundation
import FirebaseFirestore

struct CarModel: Identifiable, Codable {
    @DocumentID var id: String?  // Firestore document ID auto generates
    
    var imageURL: String
    var model: String
    var manufacturer: String
    var price: String
    var year: String
    var engineType: String
    var condition: String
}
