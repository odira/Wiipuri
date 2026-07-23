import SwiftUI

struct ALR: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("**Пример телеграммы ALR**")

                Group {
                    Divider()
                    Text("Отказ двигателя")
                    Text("Примечание:\n1) Категория срочности - CC\n2)")
                        .font(.caption2)
                    Text("**(ALR-ALERFA/УУВЖЗРЗЬ/СОБЫТИЕ\n-ЖЙТ426/А1324-ИН-ЦЛ35/М\n-СБДЕ1Е2Е3ФГХИЙ1Й3Й4Й5РВЬЫЗ/ЛБ1Д1\n-ЛЛБГ1705\n-К0820Ф290 ГОЛ МАБИР ОСТИС ГЕНДУ\n-УУВВ0349 УВГГ УУДД\n-ПБН/А1Б1Ц2Д2Д3Л1О2С2 НАЖ/СБАС РНЖС1Е2Ф1 ЦОМ/ЦАЛЛСИГНЖИСТАЙЕТ ДАТ/1ФАНСП2ПДЦ СУР/260Б ДОФ/191110 РЕГ/9ХЖЦЦ ЕЕТ/МАБИР0302 УУВЖ0302 СЕЛ/ЦПДГ ЦОДЕ/4Д20Д9 ПЕР/Ц\nРМК/2014 УТЦ РАЙОН ЛЕТРУ Ф370 ВИБРАЦИЯ ЛЕВОГО ДВИГАТЕЛЯ Т4К ДВИГАТЕЛЬ ВЫКЛЮЧЕН Т4К РЕШЕНИЕ КВС СЛЕДОВАТЬ НА А/Д НАЗНАЧЕНИЯ СНИЖЕНИЕ ДО Ф250 Т4К\nОБЪЯВИЛ СИГНАЛ БЕДСТВИЯ ОБЕСПЕЧЕНО СПРЯМЛЕНИЕ МАРШРУТА РП РДЦ ИЛЬИН)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }

                Group {
                    Divider()
                    Text("Минирование")
                    Text("Примечание:\n1) Категория срочности - CC\n2) Узнать количество людей на борту (пасс + члены экипажа)\n2) Узнать наличие опасного груза на борту")
                        .font(.caption2)
                    Text("**(АЛР-AFL043-INCERFA/УУВЖЗАЗЬ/ЭВС СООБЩИЛ О ВОЗМОЖНОМ МЕНИРОВАНИИ ВС\n-A320/M-SDIE2E3FGHJ1RWY/LB1U1\n-ULLI1110\n-K0730F310 SUGUN R904 KANET T576 NAMIN NMN3B\n-UUEE0109 UUDD UWGG\n-REG/VQBEH RMK/1202 РА УУЕЕ Н-600М. 4АСТОТА 118.1. РЕШЕНИЕ КВС ПОСАДКА НА АД НАЗНАЧЕНИЯ УУЕЕ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**(ALR-INCERFA/УНКЛЗТЗЬ\n-AUL562/A3304-IS\n-B738/M-SDRGHIRWY/H\n-UIUU0430\n-K0832F340 PILU5A PILUG B155 IKT A815 TUTEK R834 MF ITINA RW GEKLA WT GKL32A\n-UNKL0630 ULLI UWKD\n-DOF/191019 REG/VQBBW EET/UNKL0111 UNNT0201 USTV0312 USSV0403 UUWV0530 OPR/ARCHANGELSK AIR RMK/AUL562 ПРЕДПОЛОЖИТЕЛЬНО БОМБА НА БОРТУ. ПОСАДКА В УНКЛ 0740 УТЦ. ПАССАЖИРОВ 149 БАГАЖ1562 ГРУЗ 492)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                Group {
                    Divider()
                    Text("Механизация")
                    Text("Примечание:\n1) Категория срочности - CC\n2)")
                        .font(.caption2)
                    Text("**(ALR-INCERFA/URKKZTZX\n-AFL1104-IS\n-B738/M-SDIE2E3FGHJ1RWY/LB1U1\n-UUEE1200\n-K0826F310 EMGAS1F EMGAS T828 EKTUT/K0827F330 N72 UMSIS N166 ARKOK/K0844F340 N166 ND\n-URKK0240\n-DOF/210328 REG/VPBZB RMK/РАССОГЛАСОВАНИЕ ПОЛОЖЕНИЯ МЕХАНИЗАЦИИ. ПОСАДКА URKK 15.17 БЛАГОПОЛУЧНО РП ПАЩЕНКО В.М.)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
            }
        }
        .padding()
    }
}

struct ALR_Previews: PreviewProvider {
    static var previews: some View {
        ALR()
    }
}
