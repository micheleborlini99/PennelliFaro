--- Set output ---

DO(1,0) -- semaforo red OFF
DO(2,0) -- semaforo yellow OFF
DO(3,1) -- semaforo green ON 
DO(8,0) -- Colla attiva OFF 
DhInit()
DhSetForce(20)

--- Inizializzazione variabili ---

Counter = 0
Ciclo = 0
DeltaX = 10
DeltaY = 16
DeltaZ = 2
Sec = 0
Time = 0
PezziIncollati = 0
OffsetY = {0,-35,0}
OffsetZ = {0,0,50}
StatoPinza = 0
PosPinza = 45
Pausa = 700

--------------------------------

Move(P1)

while not (DI(12) == ON) do  -- verifica presenza pezzo 
    Sleep (2500)
    Sync()
    print("-- POSIZIONARE IL PEZZO NELLA DIMA --")
end



while 1 do

    Ciclo = 1

    DO(1,0) -- semaforo red OFF
    DO(2,0) -- semaforo yellow OFF
    DO(3,1) -- semaforo green ON 

    Move(P1)  -- posizione intermedia
    DhClose()
    Sleep(250)


    Move(RP(P2, OffsetY)) -- su punto presa movimento Y
    Move(P2) -- punto presa
    Sync()
    DhOpen()
    DhSetPosition(PosPinza)
    Sync()
    Sleep(500)

    Move(RP(P2,OffsetZ))  -- su punto presa movimento Z



    Move(RP(P3 , {0,0,-30}), "CP=1 SpeedS=5") -- posizione avvicinamento incollaggio


    ----- INCOLLAGGIO PEZZO ----
    Move(RP(P3 , {0,0,DeltaZ}))
    Sync()
    
    Move(RP(P3 , {0,- DeltaY,DeltaZ}))
    DO(8,1)
    Arc3(RP(P3 , {-DeltaX,0,DeltaZ}) , (RP(P3 , {0,DeltaY,DeltaZ})),"CP=1 SpeedS=1.1")
    Arc3(RP(P3 , {DeltaX,0,DeltaZ}) , (RP(P3 , {0,- DeltaY,DeltaZ})),"CP=1 SpeedS=1.1")
    Sleep(Pausa)
    DO(8,0)


Move(RP(P3 , {0,0,-30})) -- posizione avvicinamento incollaggio

Move(RP(P8 , {0,0,20}),"CP=20")
Move(P8, "CP=20")
Sleep(250)


    DhClose()
    DhSetPosition(0)
    Sync()
    Sleep(500)
    Move(RP(P8 , {0,-40,0}))
    Sync()
    print("-- RIPOSIZIONARE UN NUOVO PEZZO --")

    ResetElapsedTime()

     while not (DI(12) == ON) do
        Sleep(500)
        Time = ElapsedTime()
        Sleep(250)
        Sec = math.floor(Time / 1000)
        Sync()
        if Sec > 5 then
            Sync()
            print('-- MACCHINA INATTIVA -- ')
            DO(3,0)
            DO(2,0)
            DO(2,1) -- semaforo giallo ON 
            Sleep(5000)
         end
       end

    --DhOpen()
    ----DhSetPosition(60)
    --Sleep(1000)
    --StatoPinza = DhGetStatus()


    --if (StatoPinza == 2) then
        --Sleep(150)
        --Sync()
        --print("-- ERRORE: PEZZO PRESENTE IN PINZA, TOGLIERE IL PEZZO DALLA PINZA --")
        --Sleep(500)
        --DhClose()
        --goto Label1
    --end
    Sync()
    Counter = Counter + 1
    Sleep(150)
    print("PEZZO INCOLLATO NUMERO: ", Counter)
end

:: Label1 ::
Ciclo = 2
Sync()
print("-- MACCHINA IN STOP --")
Move(P1)  -- posizione intermedia
DO(3,0)
DO(2,0)
DO(1,1) -- semaforo rosso ON 
