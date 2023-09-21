while not (Ciclo == 2) do
    Sleep(250)
    if (Ciclo == 1) then

        if DI(11) == ON then
            Sleep(250)
            DOExecute(8,0)
            DOExecute(3,0)
            DOExecute(2,0)
            DOExecute(1,1)
            print("-- STOP PROCESSO, ERRORE , ROBOT IN PAUSA --")
            Pause()
            DOExecute(1,0) -- semaforo red OFF
            DOExecute(2,0) -- semaforo yellow OFF
            DOExecute(3,1) -- semaforo green ON 
            print("-- PROGRAMMA RIPARTITO, L'INCOLLAGGIO RIPRENDERà DAL PROSSIMO PEZZO --")
        end

    end

end
