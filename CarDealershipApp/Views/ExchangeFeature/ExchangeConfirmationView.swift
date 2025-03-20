import SwiftUI

struct ExchangeConfirmationView: View {
    var body: some View {
        VStack() {
            Spacer()
            Text("Exchange Confirmed")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your car exchange has been successfully processed.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack() {
                Text("Exchanged Car")
                    .font(.headline)
                    .padding(.top)
                
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 100)
                    .foregroundColor(.gray)
                    .padding()
                
                //got to change based off confirmation
                Text("Tesla Model 3")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Image(systemName: "arrow.right.arrow.left")
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            
            VStack() {
                Text("Received Car")
                    .font(.headline)
                    .padding(.top)
                
                Image(systemName: "car.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 100)
                    .foregroundColor(.gray)
                    .padding()
                
                //got to change based off confirmation
                Text("BMW M3")
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Spacer()
            
            Button(action: {}) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct ExchangeConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeConfirmationView()
    }
}
