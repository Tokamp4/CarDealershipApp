import FirebaseFirestore

class CarService {
    private let db = Firestore.firestore()
    
    func fetchCars(completion: @escaping ([CarModel]) -> Void) {
        db.collection("cars").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents")
                completion([])
                return
            }
            
            let cars = documents.compactMap { doc -> CarModel? in
                try? doc.data(as: CarModel.self)
            }
            
            completion(cars)
        }
    }
    
    func addCar(_ car: CarModel, completion: @escaping (Bool) -> Void) {
        do {
            _ = try db.collection("cars").addDocument(from: car) { error in
                completion(error == nil)
            }
        } catch {
            print("Error adding car: \(error)")
            completion(false)
        }
    }
}
