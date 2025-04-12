import FirebaseFirestore
import FirebaseAuth


class CarService {
    private let db = Firestore.firestore()
    
    
    static func fetchCarsForCurrentUser(completion: @escaping ([CarModel]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }

        let db = Firestore.firestore()
        db.collection("cars").whereField("userId", isEqualTo: uid).getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                let cars = documents.compactMap { try? $0.data(as: CarModel.self) }
                completion(cars)
            } else {
                completion([])
            }
        }
    }

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
    
//    func addCar(_ car: CarModel, completion: @escaping (Bool) -> Void) {
//        do {
//            _ = try db.collection("cars").addDocument(from: car) { error in
//                completion(error == nil)
//            }
//        } catch {
//            print("Error adding car: \(error)")
//            completion(false)
//        }
//    }
    func addCar(_ car: CarModel, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }

        var carToSave = car
        carToSave.userId = uid

        do {
            _ = try db.collection("cars").addDocument(from: carToSave) { error in
                completion(error == nil)
            }
        } catch {
            print("Error adding car: \(error)")
            completion(false)
        }
    }
    
    static func fetchCarsByIds(_ ids: [String], completion: @escaping ([CarModel]) -> Void) {
        let db = Firestore.firestore()
        var fetchedCars: [CarModel] = []
        let group = DispatchGroup()

        for id in ids {
            group.enter()
            db.collection("cars").document(id).getDocument { snapshot, error in
                defer { group.leave() }

                if let snapshot = snapshot, snapshot.exists {
                    if let car = try? snapshot.data(as: CarModel.self) {
                        fetchedCars.append(car)
                    }
                }
            }
        }

        group.notify(queue: .main) {
            completion(fetchedCars)
        }
    }
}
