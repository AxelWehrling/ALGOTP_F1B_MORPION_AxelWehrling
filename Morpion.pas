program Morpion;

uses crt;

const
	maxgrill=8;

//But: Mise à jour des score et affiche le joueur gagnant.
//Entree: Rien.
//Sortie: Le joueur Gagnant.
procedure AfficheVictoireManche(victoire,j1,j2 : string ; var score1 : integer ; var score2 : integer);

begin
	//Mise à jour des scores.
	if (victoire=j1) then
		score1:=score1+1;
	if (victoire=j2) then
		score2:=score2+1;
	writeln('C''est ',victoire,' qui remporte la manche!');
	writeln('Le score est de : ',j1,': ',score1,' | ',j2,': ',score2);
end;


//But: Entrer des Speudos des joueurs.
//Entree: 2 chaînes.
//Sortie: 2 chaînes.	
procedure Speudo(var j1 : string ; var j2 : string);

begin
	writeln('Veuillez entrer le Speudo du Joueur n''1:');
	readln(j1);
	writeln('Veuillez entrer le Speudo du Joueur n''2:');
	readln(j2);
end;


//But: Choisir duquel des deux joueurs est celui qui va commencer.
//Entree: 1 chaîne.
//Sortie: Le joueur qui commence.
procedure QuiCommence(var tourjoueur:integer ; j1 : string ; j2 : string);

var
	entrerjoueur:string;
	test:boolean;

begin
	repeat
		begin
			test:=false;
			writeln('Qui commence ? ',j1,' ou ',j2,' ? :');
			readln(entrerjoueur);

			if (lowercase(entrerjoueur) = lowercase(j1)) then
				begin
					writeln(j1,' Commence !');
					tourjoueur:=1;
					test:=true;
				end;

			if (lowercase(entrerjoueur) = lowercase(j2)) then
				begin
					writeln(j2,' Commence !');
					tourjoueur:=2;
					test:=true;
				end;
			
			//Vérifie si l'entrer est correcte.
			if (test=false) then
				begin
					writeln('Erreur, veuillez entrer : ',j1,'/',j2);
					delay(2000);
					clrscr;
				end;
		end;
	until (tourjoueur=1) or (tourjoueur=2);
end;


//But: Initialiser et effacer la grille de jeu
//Entree:Rien.
//Sortie:Rien.
procedure InitGrill(var Grill:array of char);
var
	i:integer;

begin
	for i:=0 to 8 do
		begin
			Grill[i]:=' ';
		end;
end;


//But:Afficher la grille de jeu à jour.
//Entree: Rien.
//Sortie: Rien.
procedure AfficheGrill(var Grill:array of char);

begin
	writeln('      ',Grill[0],' | ',Grill[1],' | ',Grill[2]);
	writeln('     ___|___|___');
	writeln('      ',Grill[3],' | ',Grill[4],' | ',Grill[5]);
	writeln('     ___|___|___');
	writeln('      ',Grill[6],' | ',Grill[7],' | ',Grill[8]);
	writeln('        |   |   ');
	writeln;
end;


//But: Demander au joueur de choisir une case à remplir de son symbole.
//Entree: 1 entier.
//Sortie: 1 charatère.
procedure ChoisirCase(var Grill:array of char ; var tourjoueur:integer ; j1 : string ; j2 : string);
var
	choix:integer;

begin
	if (tourjoueur=1) then
	begin
		repeat
		begin
			repeat
			begin	
				writeln(j1,' choisi une case vide entre 0 et 8');
				readln(choix);
				
				//Vérifie si le joueur entre un chiffre entre 0 et 8.
				if not((0<=choix) and (choix<=8)) then
				begin
					writeln('Erreur, chiffre non compris entre 0 et 8.');
					delay(2000);
					clrscr;
				end;
			end;
			until (choix>=0) and (choix<=8);
			
			//Vérifie si la case entrée n'est aps déjà prise.
			if (Grill[choix] <> ' ') then
			begin
				writeln('Erreur, cette case est deja utilisee.');
				delay(2000);
				clrscr;
			end;
		end;
		until (Grill[choix] = ' ');
		Grill[choix]:= 'X';
	end;
	
	if (tourjoueur=2) then
	begin
		repeat
		begin
			repeat
			begin	
				writeln(j2,' choisi une case vide entre 0 et 8');
				readln(choix);
				if not((0<=choix) and (choix<=8)) then
				begin
					writeln('Erreur, chiffre non compris entre 0 et 8.');
					delay(2000);
					clrscr;
				end;
			end;
			until (choix>=0) and (choix<=8);
				
			if (Grill[choix] <> ' ') then
			begin
				writeln('Erreur, cette case est deja utilisee.');
				delay(2000);
				clrscr;
			end;
		end;
		until (Grill[choix] = ' ');
		Grill[choix]:= 'O';
	end;
	
	tourjoueur:=tourjoueur+1;
	//Réinitialise le tour de joueur au joueur n°1 lorsqu'il atteint 3.
	if (tourjoueur=3) then	
		tourjoueur:=1;
	
end;

//But: Vérifie si un joueur a fait un alignement
//Entree: Rien.
//Sortie: 1 chaîne.
function AlignerVictoire (j1,j2:string ; Grill : array of char) : string;

begin
	//Réinitialise la valeur de AlignerVictoire à chaque manche.
	AlignerVictoire:='';
	
	//test si les X forment une ligne, une colonne, une diagonale.
	if ((Grill[0]='X') and (Grill[0]=Grill[3]) and (Grill[3]=Grill[6]))
		or ((Grill[1]='X') and (Grill[1]=Grill[4]) and (Grill[4]=Grill[7]))
		or ((Grill[2]='X') and (Grill[2]=Grill[5]) and (Grill[5]=Grill[8]))
		or ((Grill[0]='X') and (Grill[0]=Grill[1]) and (Grill[1]=Grill[2]))
		or ((Grill[3]='X') and (Grill[3]=Grill[4]) and (Grill[4]=Grill[5]))
		or ((Grill[6]='X') and (Grill[6]=Grill[7]) and (Grill[7]=Grill[8]))
		or ((Grill[0]='X') and (Grill[0]=Grill[4]) and (Grill[4]=Grill[8]))
		or ((Grill[6]='X') and (Grill[6]=Grill[4]) and (Grill[4]=Grill[2])) then
		begin
			AlignerVictoire:=j1;
		end;
	//test si les O forment une ligne, une colonne, une diagonale.
	if ((Grill[0]='O') and (Grill[0]=Grill[3]) and (Grill[3]=Grill[6]))
		or ((Grill[1]='O') and (Grill[1]=Grill[4]) and (Grill[4]=Grill[7]))
		or ((Grill[2]='O') and (Grill[2]=Grill[5]) and (Grill[5]=Grill[8]))
		or ((Grill[0]='O') and (Grill[0]=Grill[1]) and (Grill[1]=Grill[2]))
		or ((Grill[3]='O') and (Grill[3]=Grill[4]) and (Grill[4]=Grill[5]))
		or ((Grill[6]='O') and (Grill[6]=Grill[7]) and (Grill[7]=Grill[8]))
		or ((Grill[0]='O') and (Grill[0]=Grill[4]) and (Grill[4]=Grill[8]))
		or ((Grill[6]='O') and (Grill[6]=Grill[4]) and (Grill[4]=Grill[2])) then
		begin
			AlignerVictoire:=j2;
		end;
end;

//But: Entrer le nombre de manche voulut
//Entree: Un entier.
//Sortie: Un entier.
procedure NombreManche(var manche : integer);

begin
	writeln('Combien de manche voulez vous jouer ?');
	readln(manche);
end;


//But: Affichage du résultat (Gagnant).
//Entree: Rien.
//Sortie: Le joueur gagnant ou l'égalité.
procedure VictoireFinal(score1,score2 : integer ; j1,j2 : string);

begin
	if (score1=score2) then
		writeln('C''est une egalite !!');
	if (score1>score2) then
		writeln('C''est ',j1,' qui remporte la victoire!!');
	if (score1<score2) then
		writeln('C''est ',j2,' qui remporte la victoire!!');
end;


//Programme Principale:


//But: Jouer au Morpion.
//Entrer: 3 Chaines et des entiers.
//Sortie: Jeux du Morpion.
var
	//tourjoueur = variable qui permet de savoir lequel des deux joueurs doit jouer.
	//Manche = Variable entrer par l'utilisateur, nombre de manche désiré.
	//score1 = score du joueur 1 , score2 = score du joueur 2.
	tourjoueur,manche,i,score1,score2:integer;
	
	//Grill = tableau où seront entrés les symboles.
	Grill:array [0..8] of char;
	
	//Speudos des joueurs.
	j1,j2,victoire:string;

BEGIN
	clrscr;
	score1:=0;
	score2:=0;
	Speudo(j1,j2);
	QuiCommence(tourjoueur,j1,j2);
	NombreManche(manche);
	//Boucle de manche qui s'arrête quand le nombre de manche entré est atteint.
	repeat
	begin
		InitGrill(Grill);
		//Boucle d'entrer de case qui s'arrête lorsqu'un joueur fasse un alignement.
		repeat
		begin
			clrscr;
			writeln('Les cases sont numerotees de gauche a droite et du haut vers le bas de 0 a 8');
			writeln;
			AfficheGrill(Grill);
			ChoisirCase(Grill,tourjoueur,j1,j2);
			AlignerVictoire(j1,j2,Grill);
		end;
		until (AlignerVictoire(j1,j2,Grill)=j1) or (AlignerVictoire(j1,j2,Grill)=j2);
		clrscr;
		AfficheGrill(Grill);
		victoire:=AlignerVictoire(j1,j2,Grill);
		AfficheVictoireManche(victoire,j1,j2,score1,score2);
		delay(6000);
	end;
	until (score1+score2=manche);
	VictoireFinal(score1,score2,j1,j2);
	readln;
END.
