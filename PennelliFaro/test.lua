local inizio = os.clock()
Count=1
Min=0
repeat 
    print("hello world", Count)
    Count=Count+1
until Count==11
print("esco dal ciclo")


print(string.format("Tempo impiegato: %.3f\n", os.clock()))

print("Ora inizio: ", os.date())
print("Ora fine: ", os.date())


time = 9000000
min =math.floor(time / (60 *1000))

  	print('Minuti ciclo: ')
  	print(min)

sec= min*60
secxpezzo=(sec / 616)   ----math.floor per arrotondare in difetto
  
	print('Tempo per pezzo: ' )
 	print(secxpezzo)


	 Go(RP(points_pallet1[Counter],{0,0,0}))