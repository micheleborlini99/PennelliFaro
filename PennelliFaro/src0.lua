  DO(4,0)
  DO(5,1)
  DO(1,0)
  DO(2,0)
  DO(3,1)

    local points_pallet1 = {}
    PalletCreate({P1,P2,P3,P4},{9,3},points_pallet1)
  Counter = 1
  Ciclo = 0
  DeltaX = 15
  DeltaY = 20
  DeltaZ = -35
  min = 0
  time = 0
  MoveJ((P5))

  Sync()
  print('ATTESA PALLET')
  Sync()
  print('ATTESA CANCELLO')
  Sync()
  while not (((DI(1) == ON) and (DI(7) == ON))) do
    Sleep(1)
  end
  Sleep(1000)
  Sync()
  print('PALLET OK')
  Sync()
  print('CANCELLO OK')
  Sleep(1000)

  Sync()
  print('INIZIO CICLO')
  MoveJ((P5))
  DO(5,0)
  DO(4,1)
  Sync()
  for count = 1, math.floor(#points_pallet1) do
    Ciclo = 1
    Sync()
    if Counter==2 then
      MoveJ((P18))
      Move(RP(points_pallet1[Counter],{0,0,150}))
    end
     Move(RP(points_pallet1[Counter],{0,0,50}),"CP=10 AccelS=20")

    Move(RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=10 SpeedS=100")
    Move(RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=2")
    Arc3(RP(points_pallet1[Counter],{DeltaX,0,DeltaZ}),RP(points_pallet1[Counter],{0,-DeltaY,DeltaZ}),"CP=1 SpeedS=2")
    Arc3(RP(points_pallet1[Counter],{-DeltaX,0,DeltaZ}),RP(points_pallet1[Counter],{0,DeltaY,DeltaZ}),"CP=1 SpeedS=2")


    time = ElapsedTime() / 1000
    if time > 60 then
    min = time / 60
    print('Minuti ciclo: ')
    print(min)
    else
    print('Secondi ciclo: ')
    print(time)
    end
    Counter = Counter+2
    Sync()
    if Counter>#points_pallet1 then
      Counter = 2
    end
  end

  DO(4,0)
  DO(5,1)
  MoveJ((P18))
  DOGroup({3,0},{1,0},{2,1})
  Sync()
  print('CICLO COMPLETATO')
