  while 1 do
  Sleep(50)

  -------Verifica feedback pallet-------

  while not Ciclo==2 do ------Continua a verificare fin quando variabile ciclo=2----
    Sleep(50)
    if Ciclo==1 then
      if DI(1) == OFF then
        print('MANCANZA PALLET!')
        DOExecute(4, 0)
        DOExecute(5, 1)
        DOExecute(3, 0)
        DOExecute(2, 0)
        DOExecute(1, 1)

        Pause()       ------se pallet NON presente pausa lavorazione-----
        DOExecute(5, 0)
        DOExecute(4, 1)
        DOExecute(1, 0)
        DOExecute(2, 0)
        DOExecute(3, 1)

        print('PALLET OK')
      end

      -------Verifica feedback torcia-------


      if DI(2) == OFF then
        print('TORCIA SPENTA!')
        DOExecute(4, 0)
        DOExecute(5, 1)
        DOExecute(3, 0)
        DOExecute(2, 0)
        DOExecute(1, 1)

        Pause()   ------se torcia NON attiva pausa lavorazione
        DOExecute(5, 0)
        DOExecute(4, 1)
        DOExecute(1, 0)
        DOExecute(2, 0)
        DOExecute(3, 1)

        print('TORCIA OK')
        end
      end
    end
   break
  end
