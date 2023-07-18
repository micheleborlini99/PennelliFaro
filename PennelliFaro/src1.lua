while not (Ciclo==2) do
  Sleep(200)
  if VerificaManuale == 1 then
    if DI(4) == ON then
      DOExecute(3, 1)
      Sleep(1 * 1000)
      DOExecute(3, 0)
      Sleep(1 * 1000)
    end
  end

    if DI(7) == ON then
      okPiastra = 1
    end

  if Ciclo==1 then
    if DI(1) == OFF then
        print('MANCANZA PALLET - ERRORE - PROGRAMMA IN STOP E MACCHINA FERMA')
        Stop = 1
        DOExecute(4, 0)
        DOExecute(5, 1)
        DOExecute(3, 0)
        DOExecute(2, 0)
        DOExecute(1, 1)
        break
    end
    if DI(2) == OFF then
        print('TORCIA SPENTA - ERRORE - PROGRAMMA IN PAUSA')
        print("ERRORE AL PEZZO NUMERO: ", Counter)
        Errore = 1
        DOExecute(4, 0)
        DOExecute(5, 1)
        DOExecute(3, 0)
        DOExecute(2, 0)
        DOExecute(1, 1)
        Pause()
        DOExecute(5, 0)
        DOExecute(4, 1)
        while not ((DI(2) == ON)) do
          Sleep(200)
        end
        DOExecute(4, 0)
        DOExecute(1, 0)
        DOExecute(2, 0)
        DOExecute(3, 1)
        print('TORCIA OK')
    end

    if (DI(9) == OFF) and (DI(10) == OFF) then
        print('CILINDRO NON A FINE CORSA - ERRORE - PROGRAMMA IN STOP E MACCHINA FERMA')
        DOExecute(4, 0)
        DOExecute(5, 1)
        DOExecute(3, 0)
        DOExecute(2, 0)
        DOExecute(1, 1)
        Stop = 1
        break
    end
  end
end
