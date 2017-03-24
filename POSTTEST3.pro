DOMAINS 
 pelajaran, nama, nilai = symbol

PREDICATES
nondeterm matkul(pelajaran, nama, nilai)

CLAUSES
matkul(ai, rofi, a).
matkul(ai, farhan, d).
matkul(ai, yoan, c).
matkul(ai, naufal, b).
matkul(ai, ipeh, e). 

matkul(fw, geo, e).
matkul(fw, indra, d).
matkul(fw, nengnong, c).
matkul(fw, ara, b).
matkul(fw, laras, a). 

matkul(smbd, tari, c).
matkul(smbd, vanda, b).
matkul(smbd, bunga, a).
matkul(smbd, ghina, d).
matkul(smbd, annisa, e). 

GOAL
 matkul(_,Tidak_Lulus, d); matkul(_,Tidak_Lulus, e).
 %mencari mahasiswa yang tidak lulus. 