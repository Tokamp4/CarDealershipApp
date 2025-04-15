import SwiftUI

struct ListingsView: View {
    
    @ObservedObject private var viewModel = ListingsViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                
                // Top bar with action buttons
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: ListCarView()) {
                        HStack {
                            Image(systemName: "tag.fill")
                            Text("Sell Your Car")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.horizontal)

                // Show loading or grid
                if viewModel.cars.isEmpty {
                    Spacer()
                    ProgressView("Loading cars...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.2)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            // Original cars
                            ForEach(viewModel.cars) { car in
                                NavigationLink(destination: CarDetailsView(car: car)) {
                                    CarCardView(car: car)
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                }
                            }
                            
                            // Duplicate some listings for now
                            ForEach(viewModel.cars.prefix(4)) { car in
                                NavigationLink(destination: CarDetailsView(car: car)) {
                                    CarCardView(car: car)
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                }
                            }
                            
                            ForEach(viewModel.cars.prefix(4)) { car in
                                NavigationLink(destination: CarDetailsView(car: car)) {
                                    CarCardView(car: car)
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .padding(.horizontal)
            .onAppear {
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
