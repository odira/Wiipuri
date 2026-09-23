import SwiftUI

struct ALD: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Group {
                    Divider()
                    Text("Неопознанная метка")
                    Text("Примечание:\n1) Категория срочности - CC\n2) Время, место\n3) Описание метки\n4) Скорость, курс, высота\n5) Объявление сигнала \"Режим\"\n6) ФИО РП ")
                        .font(.caption2)
                    Text("**(АЛД-ЗЗЗЗЗ\n-DOF/220123 RМК/0845 УТЦ ЮГО-ЗАПАДНЕЕ УМСИС 95 КМ ОБНАРУЖЕНА НЕОПОЗНАННАЯ МЕТКА СКОРОСТЬ 220 КМ4 КУРС 035 ГРАД ВЫСОТА НЕИЗВЕСТНА РП ИЛЬИН)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**(АЛД\n-ДОФ/211219 РМК/2205 ОБНАРУЖЕНИЕ НЕОПОЗНАННОЙ ОТМЕТКИ 5115СШ 03750ВД РАЙОН СТАРЫЙ ОСКОЛ ВЫСОТА НЕОПРЕДЕЛЕНА СКОРОСТЬ ОКОЛО 190 КМ/4 УСТОЙЧИВО СОПРОВОЖДАЕТСЯ ДО ГТ 5211СШ 04155ВД СМЕЩЕНИЕ НА СЕВЕРО ВОСТОК НЕОПОЗНАННАЯ МЕТКА ОРГАНАМИ ПВО КЛАССИФИЦИРУЕТСЯ КАК МЕТЕООБРАЗОВАНИЕ СИГНАЛ РЕЖИМ НЕ ОБЪЯВЛЯЛСЯ РП РДЦ ГАВРИКОВ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**В ДОПОЛНЕНИЕ К НР192254\n(АЛД\n-ДОФ/211219 РМК/2331 ПРОПАДАНИЕ НЕОПОЗНАННОЙ ОТМЕТКИ В ГТ 5211СШ 04155ВД НЕОПОЗНАННАЯ МЕТКА ОРГАНАМИ ПВО КЛАССИФИЦИРУЕТСЯ КАК МЕТЕООБРАЗОВАНИЕ СИГНАЛ РЕЖИМ НЕ ОБЪЯВЛЯЛСЯ РП РДЦ ГАВРИКОВ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }

                Group {
                    Divider()
                    Text("Проблема с наддувом")
                    Text("**(АЛД-MSR729-BCS3/M\n-DOF/210505 REG/SUGFD RМК/1123 UTC ПОД УНЕПА Ф330 КВС ДОЛОЖИЛ О ПРОБЛЕМЕ С НАДДУВОМ ЗАПРОСИЛ СНИЖЕНИЕ ДО Ф310 И ПРИНЯЛ РЕШЕНИЕ СЛЕДОВАТЬ НА АЭРОДРОМ НАЗНАЧЕНИЯ ДОМОДЕДОВО РП ПОЛЕТОВ НЕМУДРОВ 0.В.)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**(АЛД-SBI2056-B738/M\n-DOF/210501 REG/VQBVM RMK/1201 УТЦ ПОД МОЛИК Ф220 КВС ДОЛОЖИЛ О НЕИСПРАВНОСТИ СИСТЕМЫ НАДДУВА ЗАПРОСИЛ ЗАНЯТИЕ Ф240 И РЕШЕНИИ СЛЕДОВАТЬ НА АЭРОДРОМ НАЗНАЧЕНИЯ ДОМОДЕДОВО. РП ПОЛЕТОВ БОРИСОВ В.Г.)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                Group {
                    Divider()
                    Text("Срабатывание TCAS RA")
                    Text("**(АЛД-AFL1485-IS\n-B738/M-SADIE2E3FGHJ1RWY/LB1U1\n-UNKL0240\n-K0835F360 APRUS B800 ADONI R372 NH P982 GIKES N987 POBEM N869 LIKNU P982 ANDAT N155 GOBOM T187 ROMTA ROMTA3E\n-UUEE0438 UUDD\n-PBN/B1D1O1S2-DOF/220525 REG/RA73117 CODE/151D9D EET/UNNT0025 USTV0142 USSV0221 ULLL0338 UUWV0356 SEL/GJAH RМК/0648 УТЦ Р-ОН РАНТО В СНИЖЕНИИ ДО Ф340 ДОКЛАД ЭВС TCAS RA ВСТРЕ4НОЕ ВС УТА333 Ф 330 РП ИЛЬИН)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                Group {
                    Divider()
                    Text("Нарушение интервалов эшелонирования")
                    Text("**(АЛД-80733-IM\n-T134/M-SDRYWG/S\n-UUOB1300\n-K0750F290 MEBUP M853 TUMIT N156 UBONA T323 OTPAD T469 TENRI TENRI2U\n-XUMU0105 UUBD UUEM\n-STS/24 PBN/B2B3 DOF/220430 REG/RA65733 EET/UUWV0005 OPR/RUSSIAN AIR FORCE PER/D RMK/FIO/САЛТАНОВ MIN/100 1.0 100 1.0 WZL.MIN B/O 0.4 POSADKA SOGLASOWANA РМК/1309 Р-ОН ТОФРИ Ф200 СРАБАТЫВАНИЕ ИКС В РЕЖИМЕ КС С ВС ГОСАВИАЦИИ В РАЙОНЕ ДЕЙСТВИЯ ВР2250. МАРШРУТ ПОЛЕТА 80733 БЫЛ СОГЛАСОВАН С ОД 6А ПВО РП ИЛЬИН)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**(RMK/СРАБАТЫВАНИЕ ИКС В РЕЖИМЕ КС С ВС РЕЙСА ЕЛЫ611 НА Ф245 ИЗ-ЗА НЕСАНКЦИОНИРОВАННОГО НАБОРА ВЫСОТЫ БОРТОМ 94571 ГОРИЗОНТАЛЬНЫЙ ИНТЕРВАЛ ОКОЛО 10 КМ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                Group {
                    Divider()
                    Text("Больной пассажир")
                    Text("**(АЛД-NWS647-B738/M\n-DOF/210702 UTC/1945 REG/VPBSA RMK/ПОД ОЛИНУ Ф350 КВС ДОЛОЖИЛ О ДВУХ БОЛЬНЫХ ПАССАЖИРАХ С ПРИМЕНЕНИЕМ СИГНАЛА СРОЧНОСТИ ПАН И РЕШЕНИИ ПРОИЗВЕСТИ ПОСАДКУ НА НЕЗАПЛАНИРОВАННОМ АЭРОДРОМЕ УРВА. РУКОВОДИТЕЛЬ ПОЛЕТОВ КИРИН А.С.)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }

                Group {
                    Divider()
                    Text("Попадание птицы")
                    Text("**(АЛД-PBD460-B738/M\n-DOF/210702 REG/VQBTI RMK/ПОСЛЕ ВЗЛЕТА ПОПАДАНИЕ ПТИЦЫ В ОБТЕКАТЕЛЬ ФЮЗЕЛЯЖА, ВИДИМОСТЬ 10КМ ОБЛА4НОСТЬ 7 ОКТ, ЭКИПАЖ ПРИНЯЛ РЕШЕНИЕ СЛЕДОВАТЬ НА АД НАЗНАЧЕНИЯ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**(АЛД-PBD505\n-B738/M\n-DOF/220815 REG73232\n-А/К ПОБЕДА RMK/ЭКИПАЖ В 0502 УТЦ ДОЛОЖИЛ СТОЛКНОВЕНИЕ С ПТИЦЕЙ НА РАЗБЕГЕ ПРАВУЮ 4АСТЬ НОСОВОГО ОБТЕКАТЕЛЯ ПАРАМЕТРЫ В НОРМЕ ПРИНЯЛ РЕШЕНИЕ ПРОДОЛЖИТЬ ПОЛЕТ НА АЭРОДРОМ НАЗНА4ЕНИЯ РП ДАИДБЕКОВ Б.Х.)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }

                Group {
                    Divider()
                    Text("Техпричина")
                    Text("**(АЛД-SBI2092-A20N/M\n-DOF/210704 REG/VQBCH UTC/1410 RMK/ВЗЛЕТ С ГЕЛЕНДЖИКА 1352 УТЦ. В 1410 УТЦ ЗАПРОСИЛ У ДИСПЕТ4ЕРА ДПП КРАСНОДАР СЛЕДОВАТЬ В ПУНКТ НАЗНА4ЕНИЯ НА ЭШЕЛОНЕ 100 ПО ТЕХ.ПРИЧИНЕ.РП КРУГЛОВ А.Г.)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                Group {
                    Divider()
                    Text("Неисправность автопилота")
                    Text("**(АЛД-SVR265-IS/n-A320/M-SDE2FGHIRUWYZ/SBq\n-UUDD1900\n-K0809F370 KOGOM4N KOGOM L94 NAMER T765 GEMKI L94 LOMBI LOMBI6S\n-USSS0156 USCC\n-PBN/A1B1C1D1O1S1S2 DAT/CPDLCX SUR/260B DOF/211227 REG/VQBAG EET/UWWW0043 USSV0124 SEL/BLCE CODE/4248EA OPR/SVR PER/C TALT/UUWW RMK/TCAS DSP CTC +73433449246 RMK/1922 Р/А УУДД 3000 ФУТОВ ЭВС ДОЛОЖИЛ 4ТО АВТОПИЛОТ НЕ ПОДКЛЮЧАЕТСЯ Т4К РЕШЕНИЕ ЭВС СЛЕДОВАТЬ НА А/Д НАЗНА4ЕНИЯ ЕКАТЕРИНБУРГ РП ЛИМАНОВ ВЮ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                    Text("**(АЛД-SVR265-IS/n-A320/M-SDE2FGHIRUWYZ/SBq\n-UUDD1900\n-K0809F370 KOGOM4N KOGOM L94 NAMER T765 GEMKI L94 LOMBI LOMBI6S\n-USSS0156 USCC\n-PBN/A1B1C1D1O1S1S2 DAT/CPDLCX SUR/260B DOF/211227 REG/VQBAG EET/UWWW0043 USSV0124 SEL/BLCE CODE/4248EA OPR/SVR PER/C TALT/UUWW RMK/TCAS DSP CTC +73433449246 RMK/1922 Р/А УУДД 3000 ФУТОВ ЭВС ДОЛОЖИЛ 4ТО АВТОПИЛОТ НЕ ПОДКЛЮЧАЕТСЯ Т4К РЕШЕНИЕ ЭВС СЛЕДОВАТЬ НА А/Д НАЗНА4ЕНИЯ ЕКАТЕРИНБУРГ ДОПОЛНЕНИЕ/1931 РАЙОН ТО4КИ МЕФЕД Ф180 ДОКЛАД ЭВС СИСТЕМА ВОССТАНОВЛЕНА РП ЛИМАНОВ ВЮ)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                Group {
                    Divider()
                    Text("Поломка триммера стабилизатора")
                    Text("**(АЛД-AFL1213-B738/M\n-PBN/B1D1O1S2 CODE/151DA2 DOF/220605 REG/RA73122 EET/UUWV0026 SEL/KLDQ RMK/ACAS II EQUIPPED RMK/1434 УТЦ РАЙОН ОТКОЛ Ф340 ДОКЛАД КВС ПОЛОМКА ТРИММЕРА СТАБИЛИЗАТОРА ЗАПРОСИЛ ЗАХОД С ПРЯМОЙ СИГНАЛ СРОЧНОСТИ/БЕДСТВИЯ НА ОБЪЯВЛЯЛ РП РДЦ ИЛЬИН)**")
                        .font(.callout)
                        .foregroundColor(Color.blue)
                }
                
                VStack {
                    Group {
                        Divider()
                        Text("Отказ TCAS и потеря статуса RVSM")
                        Text("**(АЛД-SDM6234-A319/M\n-PBN/B1D1A1S2O1 DOF/220506 REG/RA73186 EET/UUWV0026 ULLL0142 SEL/EJGP CODE/151DE2 RMK/ТЦАС ИИ RMK/МАРШРУТ САМАРА - САНКТ-ПЕТЕРБУРГ В 13.17 УТЦ МЗН Т750 РАЙОН БМК НА ЭП 320 ЭВС ДОЛОЖИЛ ОБ ОТКАЗЕ ТКАС И ПОТЕРИ СТАТУСА РВСМ ЗАПРОСИЛ ЭП 280 РЕШЕНИЕ СЛЕДОВАТЬ НА АЭРОДРОМ НАЗНА4ЕНИЯ СИГНАЛ СРО4НОСТИ НЕ ОБЪЯВЛЯЛСЯ РП РДЦ ПАРШКОВ Ю.Н.)**")
                            .font(.callout)
                            .foregroundColor(Color.blue)
                    }
                    Group {
                        Divider()
                        Text("Лазер")
                        Text("**(ALD-UTA355-B738/M\n-PBN/A1B1C1D1O2O3 DOF/220816 REG/RA73091 EET/UWWW0034 UATT0116 URRV0232 OPR/UTA PER/D RMK/Г.Т. 54.35 СШ 41.05 ВД 23:06 ЭШ370 ДОКЛАД ЭВС ОБ ОСВЕЩЕНИИ ЛАЗЕРОМ ЗЕЛЕННОГО ЦВЕТА С ЗЕМЛИ. НА БЕЗОПАСНОСТЬ ПОЛЕТА НЕ ПОВЛИЯЛО. РП РДЦ ИВУШКИН)**")
                            .font(.callout)
                            .foregroundColor(Color.blue)
                    }
                }
            }
        }
        .padding()
    }
}

struct ALD_Previews: PreviewProvider {
    static var previews: some View {
        ALD()
    }
}
