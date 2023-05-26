 -----Settaggio output------
DO(4,0)
DO(5,1)
DO(1,0)
DO(2,0)
DO(3,1)

------Inizializzazione pallet------

    local points_pallet1 = {}
    PalletCreate({P1,P2,P3,P4},{9,3},points_pallet1)

----Inizializzazione variabili------
  Counter = 1
  Ciclo = 0
  DeltaX = 15
  DeltaY = 20
  DeltaZ = -35
  Min = 0
  Time = 0
  MoveJ((P5))

------Verifica condizioni pre start ciclo di lavoro-------
  Sync()
  print('ATTESA PALLET')
  Sync()
  print('ATTESA CANCELLO')
  Sync()
  while not (((DI(1) == ON) and (DI(7) == ON))) do   ----Verifica cancello chiuso (DI7) e pallet in posizione (DI1)----
    Sleep(1)
  end
  Sleep(1000)
  Sync()
  print('PALLET OK')
  Sync()
  print('CANCELLO OK')
  Sleep(1000)

--------settaggi di Inizio ciclo--------
  Sync()
  print('INIZIO CICLO')
  MoveJ((P5))
  DO(5,0)
  DO(4,1)
  Sync()

------Inizio ciclo--------

  for count = 1, math.floor(#points_pallet1) do
    Ciclo = 1
    Sync()
    if Counter==2 then
      MoveJ((P18))
      Move(RP(points_pallet1[Counter],{0,0,150}))
    end
    ResetElapsedTime()
     Move(RP(points_pallet1[Counter],{0,0,10}),"CP=10 AccelS=20")

    Move(RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=10 SpeedS=100")
    Move(RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=2")
    Arc3(RP(points_pallet1[Counter],{DeltaX,0,DeltaZ}),RP(points_pallet1[Counter],{0,-DeltaY,DeltaZ}),"CP=1 SpeedS=2")
    Arc3(RP(points_pallet1[Counter],{-DeltaX,0,DeltaZ}),RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=2")


    print('Numero pezzo piastra:')
    print(Counter)
    Time = ElapsedTime() / 1000
    print('Secondi ciclo: ')
    print(Time)                 ---------stampa tempo per pezzo-------
    Counter = Counter+2
    Sync()
    if Counter>#points_pallet1 then
      Counter = 2
    end
  end
--------Fine ciclo---------

-----Settaggi post ciclo e fermo macchina-----
  Ciclo = 0
  DO(4,0)
  DO(5,1)
  MoveJ((P18))
  DOGroup({3,0},{1,0},{2,1})
  Sync()
  print('CICLO COMPLETATO')
