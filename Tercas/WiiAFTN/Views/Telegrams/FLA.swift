import SwiftUI

struct FLA: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Пример телеграммы FLA")
                    .bold()

                Group {
                    Text("Примечание:\n1) Категория срочности - CC\n2)")
                        .font(.caption2)
                    Text("**(FLA-TSO1234\n-UUEE0123 UUDD\n-DOF/220123 REG/VQBYD РМК/2341 УТЦ Р-ОН ОЛОПИ Ф360 РЕШЕНИЕ КВС М/У УУЕЕ**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
            }
        }
        .padding()
    }
}

struct FLA_Previews: PreviewProvider {
    static var previews: some View {
        FLA()
    }
}
