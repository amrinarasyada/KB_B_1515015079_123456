/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

domains
  name,sex,occupation,object,vice,substance = symbol %domains disini untuk mendeklarasikan kalau variabel2 tersebut itu simbol
  age=integer %mendeklarasikan variabel age itu integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o) 
  %dikatakan person/orang dengan parameter nama, umur, jeniskelamin, dan pekerjaan.
  %nondeterm berarti ada banyak kemungkinan2 yang bisa diberikan. output semua maupun pencampuran input output.
  
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  %orang dengan nama tersebut (selanjutnya saya sebut nama)mempunyai suatu hubungan/peristiwa dengan orang nama lainnya, nondeterm bisa inputan atau i/o.
  
  killed_with(name,object) - determ (i,o)
  %orang dengan nama itu dibunuh dengan suatu objek. kemungkinan yang diberikan hanya satu. input namenya dan output object(determ).
  
  killed(name) - procedure (o) %orang dengan nama tersebut terbunuh. output
  killer(name) - nondeterm (o) %orang dengan nama tersebut membunuh. output
  motive(vice) - nondeterm (i) %vice/sesuatu yang buruk adalah motivenya. input
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i) %nama berlumur/smeared in dengan suatu zat/substance. bisa i/o. atau input saja
  owns(name,object) - nondeterm (i,i) %nama mempunyai suatu objek. inputan.
  operates_identically(object,object) - nondeterm (o,i) %objek mempunyai operasi yg identik dengan objek lain. i/o
  owns_probably(name,object) - nondeterm (i,i) %nama kemungkinan mempunyai objek. inputan.
  suspect(name) - nondeterm (i) %nama adalah tersangka/suspect

/* * * Facts about the murder * * */
clauses

%Klausa disini fakta-fakta yang diberikan.
  person(bert,55,m,carpenter). %person(nama bert, umur 55, laki2, tukang kayu)
  person(allan,25,m,football_player). %person(nama allan, umur 25, laki2, pemain bola)
  person(allan,25,m,butcher). %person(nama allan, umur 25, laki2, algojo)
  person(john,25,m,pickpocket). %person(nama john, umur 25, laki2, pencopet)

  had_affair(barbara,john). %barbara punya hubungan/peristiwa dengan john
  had_affair(barbara,bert). %barbara punya hubungan/peristiwa dengan bert
  had_affair(susan,john). %susan punya hubungan/peristiwa dengan bert

  killed_with(susan,club). %susan terbunuh dengan alat pemukul
  killed(susan). %susan terbunuh

  motive(money). %motif uang
  motive(jealousy). %motif cemburu
  motive(righteousness). %motif keadilan

  smeared_in(bert,blood). %bert berlumuran darah
  smeared_in(susan,blood). %susan berlumuran darah
  smeared_in(allan,mud). %allan berlumuran darah
  smeared_in(john,chocolate). %john berlumuran coklat
  smeared_in(barbara,chocolate). %barbara berlumuran coklat

  owns(bert,wooden_leg). %bert punya kaki kayu
  owns(john,pistol). %john punya pistol

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club). %kaki kayu identik dengan alat pemukul
  operates_identically(bar, club). %balok identik dengan alat pemukul
  operates_identically(pair_of_scissors, knife). %sepasang gunting identik dengan pisau
  operates_identically(football_boot, club). %football boot identik dengan alat pemukul

  owns_probably(X,football_boot):-    %X kemungkinan mempunyai footbal boot jika X dengan umur dan jenis kelamin apapun adalah pemain bola
	person(X,_,_,football_player). 
  owns_probably(X,pair_of_scissors):- %X kemungkinan mempunyai sepasang gunting jika X dengan umur dan jenis kelamin apapun adalah penata rambut
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-           %X kemungkinan mempunyai object jika faktanya X memang punya objek itu.
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-				%X tersangka jika susan terbunuh dengan senjata dan suatu objek identik dengan senjata dan X kemungkinan mempunyai objek tersebut.
	killed_with(susan,Weapon) ,
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-				%X tersangka jika motifnya cemburu dan X (umur&pekerjaan apapun)seorang pria dan susan mempunyai hubungan/peristiwa dengan X.
	motive(jealousy),
	person(X,_,m,_),
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-    %X tersangka jika motifnya cemburu dan X (umur&pekerjaan apapun)seorang wanita, dan X mempunyai hubungan/peristiwa dengan Man dan susan mempunyai hubungan/peristiwa dengan Man itu juga. .
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-				%X tersangka jika motifnya uang dan X mempunyai pekerjaan pencopet(dengan umur dan jenis kelamin apapun).
	motive(money),
	person(X,_,_,pickpocket).

  killer(Killer):-					%Pembunuh adalah pembunuh jika pembunuh adalah orang tanpa dibatasi usia, umur, dst. 
	person(Killer,_,_,_),				%dan terbunuh adalah pembunuh
	killed(Killed),
	Killed <> Killer, /* It is not a suicide */	
	suspect(Killer),				%pembunuh itu tersangka
	smeared_in(Killer,Goo),				%pembunuh ternodai/berlumuran Goo
	smeared_in(Killed,Goo).				%terbunuh juga ternodai/berlumuran goo

goal
  killer(X).
  
  
%Untuk analisis unifikasi dan trackbacking dapat dilihat pada bagan yang terdapat pada file word POSTTEST4.1.docx
  
  
  
  