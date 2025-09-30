import SwiftUI

struct ContentView: View {
    
    enum Steps {
        case one
        case two
    }
    @State private var showMain = false
    @State private var step: Steps = .one
    let delay: TimeInterval = 1.0
    
    var body: some View {
        ZStack {
            Image("backStart")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            if step == .one {
                VStack {
                    Spacer()
                    Image(.logoStart)
                    Spacer()
                    Text("Please wait...")
                        .foregroundStyle(.white)
                        .padding(.bottom, 46)
                        .font(.custom(.MontserratRegular, size: 18))
                }
            } else {
                VStack {
                    Text("Make chef\nfrom yourself")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .font(.custom(.MontserratMedium, size: 40))
                    
                    Button {
                        showMain.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.green)
                                .frame(width: 136, height: 50)
                            Text("Get started")
                                .font(.custom(.MontserratMedium, size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(.chicken)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 340)
                        .offset(x: step == .two ? 0 : UIScreen.main.bounds.width)
                        .animation(.easeOut(duration: 0.8), value: step)
                        .offset(x: 140, y: 100)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                step = .two
            }
        }
        .fullScreenCover(isPresented: $showMain) {
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
