import SwiftUI

struct SanPabloLoadingOverlay: View {
    let progress: Double
    @State private var pickaxeAngle: Double = -30

    var body: some View {
        ZStack {
            // Небо
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Облака
            SanPabloCloudsView()

            // Лужайка
            VStack {
                Spacer()
                Ellipse()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.8), Color.green]),
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(height: 120)
                    .offset(y: 40)
            }

//            VStack(spacing: 0) {
//                // Логотип сверху
//                HStack {
//                    Spacer()
//                    Image("title")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(maxWidth: 180, maxHeight: 120)
//                        .padding(.top, 60)
//                    Spacer()
//                }
//                Spacer()
//            }

            // Шахтер и камни
            VStack {
                Spacer()
                ZStack {
                    // Камни (по прогрессу исчезают)
                    HStack(spacing: 18) {
                        ForEach(0..<6) { idx in
                            if progress < Double(idx + 1) / 6.0 {
                                Image(systemName: "circle.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundColor(.gray.opacity(0.7))
                                    .offset(y: 18)
                            }
                        }
                    }
                    // Шахтер
                    VStack(spacing: 0) {
                        ZStack {
                            // Кирка (анимируется)
                            Image(systemName: "hammer.fill")
                                .resizable()
                                .frame(width: 38, height: 38)
                                .foregroundColor(.brown)
                                .rotationEffect(.degrees(pickaxeAngle), anchor: .bottomTrailing)
                                .offset(x: 18, y: -10)
                                .shadow(radius: 2)
                                .animation(.easeInOut(duration: 0.4).repeatForever(autoreverses: true), value: pickaxeAngle)
                            // Шахтер
                            
                        }
                        // Земля под шахтером (progress-бар)
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.brown.opacity(0.3))
                                .frame(width: 160, height: 18)
                            Capsule()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [Color.brown, Color.yellow.opacity(0.7)]),
                                    startPoint: .leading,
                                    endPoint: .trailing))
                                .frame(width: CGFloat(progress) * 160, height: 18)
                                .animation(.easeInOut(duration: 0.3), value: progress)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.bottom, 60)
                Spacer().frame(height: 80)
            }

            // Процент загрузки
            VStack {
                Spacer()
                Text("Earn: \(Int(progress * 100))%")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                    .padding(.bottom, 32)
            }
        }
        .onAppear {
            withAnimation {
                pickaxeAngle = 30
            }
        }
    }
}

private struct SanPabloCloudsView: View {
    var body: some View {
        ZStack {
            // Несколько облаков
            Group {
                SanPabloCloudShape()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: 120, height: 50)
                    .offset(x: -100, y: -120)
                SanPabloCloudShape()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 90, height: 36)
                    .offset(x: 80, y: -100)
                SanPabloCloudShape()
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 70, height: 28)
                    .offset(x: 0, y: -60)
            }
        }
    }
}

private struct SanPabloCloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width, h = rect.height
        path.addEllipse(in: CGRect(x: w*0.0, y: h*0.3, width: w*0.5, height: h*0.5))
        path.addEllipse(in: CGRect(x: w*0.3, y: h*0.0, width: w*0.5, height: h*0.7))
        path.addEllipse(in: CGRect(x: w*0.5, y: h*0.3, width: w*0.4, height: h*0.5))
        return path
    }
}

#Preview {
    SanPabloLoadingOverlay(progress: 0.4)
}

