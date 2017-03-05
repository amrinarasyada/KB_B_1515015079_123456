predicates %katapenghubung
 nondeterm  bisamakan(symbol,symbol)  %nondeterm = mendefinisikan i/o yang diinginkan, disini saya bebaskan pake apa aja
 nondeterm  karnivora(symbol)  %karnivora simbol, dst.
 nondeterm  herbivora(symbol)  
 nondeterm  daging(symbol)
 nondeterm  sayur(symbol) 
 nondeterm  suka(symbol,symbol)

clauses
  bisamakan(X,Y):- %X bisa makan Y, jika X=karnivora, Y=daging, X suka Y
	karnivora(X), 
	daging(Y),
	suka(X,Y); % atau X=herbivora, Y=Sayur, X suka Y
	herbivora(X),
   	sayur(Y),
   	suka(X,Y).

  karnivora(singa).
  karnivora(macan).
  herbivora(kelinci).
  herbivora(rusa).
  daging(ayam).
  daging(sapi).
  sayur(wortel).
  sayur(bayam).
  suka(kelinci, wortel).
  suka(kelinci, pizza).
  suka(rusa, rumput).
  suka(singa, sapi).
  suka(macan, kelinci).
	%diatas nama2 hewan karnivora, herbivora, makanan daging sayur, dan kesukaan
goal 
 bisamakan(Who,What); %goalnya siapa yang bisa makan apa. 
 suka(kelinci,What). %atau kesukaan kelinci apa. dan bisa ditambahin yang lain2 juga. 
  
