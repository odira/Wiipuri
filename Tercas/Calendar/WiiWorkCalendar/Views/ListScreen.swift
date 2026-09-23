import SwiftUI

struct ControlsBar: View {
    
    var month: String
    var year: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Image(systemName: "arrowtriangle.left.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
            Text("\(month)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Image(systemName: "arrowtriangle.right.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
            Spacer()
            
            Image(systemName: "arrowtriangle.left.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)

            Text("\(year)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Image(systemName: "arrowtriangle.right.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
            
            Spacer()
        }
    }
}

struct ListScreen: View {
    @State private var month = "December"
    @State private var year = "2022"
    
    @State private var person = "Владимир Ильин"

    var body: some View {
        VStack {
            ControlsBar(month: month, year: year)
                .padding()
            
            List(0 ..< 50) { item in
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        
                        Text("\(person)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                    
                    GeometryReader { geo in
                        let itemSize: CGFloat = geo.size.width / 36
                        
                        HStack(spacing: 0) {
                            ForEach(-2..<34) { i in
                                ZStack {
                                    Text("00")
                                        .hidden()
                                        .frame(width: .infinity, height: .infinity)
                                        .aspectRatio(1, contentMode: .fill)
                                        .overlay {
                                            Text("\(i)")
                                                .cornerRadius(2)
                                                .font(.caption)
                                        }
                                        .background(Color.yellow)
                                        .padding(1)
                                }
                                .frame(width: itemSize, height: itemSize)
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct ListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}
