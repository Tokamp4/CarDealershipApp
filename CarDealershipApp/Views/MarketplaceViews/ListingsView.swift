
import SwiftUI

struct ListingsView: View {
    
    @StateObject private var viewModel = ListingsViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 15){
                    NavigationLink(destination: ListCarView()) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .frame(width: 300, height: 30)
                            .overlay(
                                HStack {
                                    Image(systemName: "tag.fill")
                                        .foregroundStyle(.white)
                                    Text("Sell")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                            )
                    }
                    
//                    Button {
//                        // Add search logic here
//                    } label: {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.blue)
//                            .frame(width: 170, height: 30)
//                            .overlay(
//                                HStack {
//                                    Image(systemName: "magnifyingglass")
//                                        .foregroundStyle(.white)
//                                    Text("Search")
//                                        .font(.headline)
//                                        .foregroundStyle(.white)
//                                }
//                            )
//                    }
                }
                .padding(.top)
                
                if viewModel.cars.isEmpty {
                    Spacer()
                    ProgressView("Loading cars...")
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.cars) { car in
                                NavigationLink(destination: CarDetailsView(car: car)) {
                                    CarCardView(car: car)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear{
                viewModel.startListeningToUser()
            }
            .navigationTitle("Marketplace")
        }
    }
}

struct ListingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView()
    }
}
