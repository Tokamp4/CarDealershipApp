import SwiftUI

struct ExchangeView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray)
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            
            Text("Car Exchange")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Car You’re Exchanging From Your Listings")
                .font(.subheadline)
                .padding(.top)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            VStack {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Text("Add photos/videos")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
            
            Image(systemName: "arrow.right.arrow.left")
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
            
            Text("Car You’re Eligible to Swap to")
                .font(.subheadline)
                .padding(.bottom)
                .foregroundColor(.gray)
            
            VStack {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Text("No car selected")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
            
            Button(action: {
                
            }) {
                Text("View other eligible swaps")
                    .padding(.top)
                    .font(.headline)
                    .foregroundColor(.blue)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

struct ExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeView()
    }
}
