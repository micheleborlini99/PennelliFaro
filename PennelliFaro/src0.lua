  DO(4,0)
  DO(5,1)
  DO(1,0)
  DO(2,0)
  DO(3,1)
  DO(7,0)
  DO(6,0)
  MoveJ((P19))
  Sleep(2 * 1000)
  DO(7,0)
  DO(6,1)
  Sync()
  ResetElapsedTime()
  while not ((DI(9) == ON)) do
    Sleep(200)
        Time = ElapsedTime() / 1000
        if Time > 20 then
          Sync()
          print("ARIA INSUFFICIENTE, MANCATO MOVIMENTO DEL CILINDRO")
          DO(3, 0)
          DO(2, 0)
          DO(1, 1)
          Pause()
          DO(1, 0)
          DO(2, 0)
          DO(3, 1)
        end
  end

------Variabili-------

Counter = 1
Ciclo = 0
DeltaX = 8
DeltaY = 16
DeltaZ = - 3
Manuale = 0
Sec = 0
Time = 0
Stop = 0
okPiastra = 0
VerificaManuale = 0
PalletCompletati = 0
Errore = 0
PezziPlasmati = 0

-------------------

    local points_pallet1 = {}
    PalletCreate({P21,P24,P23,P22},{9,6},points_pallet1)

  Sync()
  while 1 do
    Sleep(200)
    DO(1,0)
    DO(2,0)
    DO(3,1)
    Sync()


-------Verifica se programma in MANUALE-------

      if DI(4) == ON then
        VerificaManuale = 1
        Manuale = 1
        DO(7,0)
        DO(6,0)
        Sync()
        print('PROGRAMMA IN MODALITA\' MANUALE')
        Sync()
        while not (DI(4) == OFF) do
          Sleep(200)
          Sync()
          if DI(5) == ON then
            DO(7,0)
            DO(6,1)
          end
          Sync()
          if DI(6) == ON then
            DO(6,0)
            DO(7,1)
          end
          Sync()
          if (DI(6) == OFF) and (DI(5) == OFF) then
            DO(6,0)
            DO(7,0)
          end
        end
      end
VerificaManuale=0

-------Fine programma MANUALE-------


      Sync()
      if Manuale==1 then
        Manuale = 0
        Sync()
        print('PROGRAMMA IN MODALITA\' AUTOMATICA')
        DO(6,0)
        DO(7,0)
        Sleep(200)
        DO(1,0)
        DO(2,0)
        DO(3,1)
        Sleep(200)
        DO(7,0)
        DO(6,1)
      end
      Sync()
      while not (((DI(9) == ON) or (DI(10) == ON))) do
        Sleep(200)
      end

      Sync()
      print('ATTESA AVVIO CICLO')
      Sync()

-----Attesa pulsante di "OK PALLET"----

      while not ((okPiastra==1)) do
        Sleep(200)
      end
-------------------------------


      Sleep(1 * 1000)
      Counter = 1
      okPiastra = 0
      Sync()

------Verifica Teleruttore--------

      if DI(8) == OFF then
        Sync()
        print('BARRIERE OCCUPATE, SBLOCCARE...')
        Sync()
        while not ((DI(8) == ON)) do
          Sleep(200)
        end
        Sync()
        print('BARRIERE IN FUNZIONE!')
      end

---------------------------------------
      Sync()

------Movimento cilindro verso DX o SX------

      if DI(9) == ON then
        DO(6,0)
        DO(7,1)
        Sync()
        print('MUOVO IL CILINDRO VERSO DESTRA')
      else
        DO(7,0)
        DO(6,1)
        Sync()
        print('MUOVO IL CILINDRO VERSO SINISTRA')
      end

-------------------------------------
      Sync()
      Sleep(1000)

      while not (((DI(9) == OFF) and (DI(10) == OFF))) do
        Sleep(500)
      end
ResetElapsedTime()
      while not ((DI(1) == ON)) do
        Sleep(500)
        
        Time = ElapsedTime() / 1000
        if Time > 8 then
          Sync()
          print("MACCHINA IN TIMEOUT, PALLET N0N PRESENTE - INSERIRE PALLET")
          DO(3, 0)
          DO(2, 0)
          DO(1, 1)
          Sleep(1000)
          Pause()
          DO(1, 0)
          DO(2, 0)
          DO(3, 1)
        end

      end
      Sync()
      print('PALLET OK')
      Sleep(2 * 1000)
      Sync()
      while not (((DI(9) == ON) or (DI(10) == ON))) do
        Sleep(200)
      end
      Sync()
      print('CILINDRO A FINE CORSA')
      Sleep(2 * 1000)
      MoveJ((P19))

      DO(5,0)
      DO(4,1)
      Sync()
      while not ((DI(2) == ON)) do
        Sleep(200)
      end
      DO(4,0) ---Segnale di START torcia basso
      Sync()
      print('TORCIA ATTIVA')
      Sleep(1 * 1000)

      if PalletCompletati == 0 then
        Sync()
        ResetElapsedTime()
        print("ATTENDO TORCIA A TEMPERATURA...")
        Sync()
        while (Time <= 30) do
            Sleep (600)
            Time = ElapsedTime() / 1000
            if ((math.floor(Time) % 15) == 0) then
              Sync()
              print("RISCALDAMENTO TORCIA..", math.floor(Time) , " SECONDI / 30 SECONDI")
            end

        end
      end

-------Inizio ciclo di lavorazione-------

local startTime = os.time()
Sync()
print('INIZIO CICLO')
while PezziPlasmati < 54 do
  Errore = 0
  Ciclo = 1
  Sync()
  if Stop == 1 then
    MoveJ((P20))
    goto label1
  end
  if Counter==2 then
    MoveJ((P19))
    Move(RP(points_pallet1[Counter],{0,0,100}))
  end
Move(RP(points_pallet1[Counter],{0,0,20}),"SpeedS=100")

Move(RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=15")
---Movimento su pezzo---

ResetElapsedTime()
Move(RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=1.2")
Arc3(RP(points_pallet1[Counter],{DeltaX,0,DeltaZ}),RP(points_pallet1[Counter],{0,-DeltaY,DeltaZ}),"CP=1 SpeedS=1.2")
Arc3(RP(points_pallet1[Counter],{-DeltaX,0,DeltaZ}),RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=1.2")

----Fine movimento su pezzo----
       Move(RP(points_pallet1[Counter],{0,0,20}),"SpeedS=80")
Sync()
Time = ElapsedTime() / 1000
print('Numero pezzo piastra:', Counter, ' tempo pezzo:', math.floor(Time), " secondi")
Sync()
  if Errore == 0 then
  Sync()
    Counter = Counter+2
    PezziPlasmati = PezziPlasmati + 1
  end

  if Counter>#points_pallet1 then
    Counter = 2
  end
  Sleep(200)
end
Sync()
print('- CICLO COMPLETATO -')
Sleep(1000)
local endTime = os.time()
Sync()
print("DURATA CICLO: ", math.floor(os.difftime(endTime, startTime) / 60), " MINUTI")

---------Fine ciclo di lavorazione--------

      PezziPlasmati = 0
      Ciclo = 0
      DO(4,0)
      DO(5,1)
      MoveJ((P20))
      Sync()
      while not (DI(2) == OFF) do 
        Sleep(500)
      end
      Sleep (1000)
      PalletCompletati = PalletCompletati + 1
      print("PIASTRE COMPLETATE: ", PalletCompletati)
      Sleep (1000)
      Sync()
      print('TORCIA SPENTA CORRETTAMENTE')


---------Verifica se programma in MANUALE--------


      if DI(4) == ON then
        VerificaManuale=1
        Manuale = 1
        DO(7,0)
        DO(6,0)
        Sync()
        print('PROGRAMMA IN MANUALE')
        Sync()
        while not (DI(4) == OFF) do
          Sleep(200)
          Sync()
          if DI(5) == ON then
            DO(7,0)
            DO(6,1)
          end
          Sync()
          if DI(6) == ON then
            DO(6,0)
            DO(7,1)
          end
          Sync()
          if (DI(6) == OFF) and (DI(5) == OFF) then
            DO(6,0)
            DO(7,0)
          end
        end
      end
VerificaManuale=0

      -------Fine programma in MANUALE--------

      DO(3,0)
      DO(1,0)
      DO(2,1)
      Sleep(1000)
      ResetElapsedTime()
      Sync()
      print('ATTESA INIZIO LAVORAZIONE....')

      while not (okPiastra==1) do
          Sleep(599)
          Time = ElapsedTime() / 1000
          Sec=math.floor(Time)
          if ((math.floor(Sec) % 10) == 0) then
              Sync()
              print('TEMPO ATTESA: ', Sec , ' SECONDI')
              Sync()
          end
          if Time>240 then
            Ciclo = 2
            Sync()
            print('MACCHINA FERMA PER INATTIVITA\'')
            DO(3,0)
            DO(2,0)
            DO(1,1)
            goto label1
          end
        end
  end
:: label1 ::
Sync()
print("SPEGNIMENTO MACCHINA IN CORSO...")
Sleep(10 * 1000)
DO(1,0)
DO(2,0)
DO(3,0)
print('MACCHINA SPENTA PER TIMEOUT')