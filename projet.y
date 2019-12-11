%{
#include<stdlib.h>
#include<stdio.h>


%}


%token PUISSANCE
%token PG
%token PD
%token FIN
%token AG
%token AD
%token PROGRAM
%token OPMUL
%token OPAFFECT
%token ID
%token DEC
%token TYPE
%token FUNC
%token PROC
%token IF THEN REPEAT UNTIL
%token NOT
%token NB
%token PV
%token PP
%token VR
%token E
%token POINT
%token OPADD_OR
%left OPREL
%left OPPMUL
%left OPADD_PLUS OPADD_MOINS
%token END 0 "end of file"
%start programme

%%

//les regles de production

programme:	PROGRAM ID PV declarations
			declaration_sous_programmes
			instruction_composee
			POINT
;

liste_identificateurs:	ID
			|liste_identificateurs VR ID
;

declarations:	DEC declaration
				|/*vide*/
;									

declaration:liste_identificateurs PP type PV declaration
	    |liste_identificateurs PP type PV
;

type:	TYPE
;

declaration_sous_programmes:	declaration_sous_programmes
								declaration_sous_programme PV
								|/*vide*/
;

declaration_sous_programme:		entete_sous_programmes
								|declarations
								|instruction_composee
;

entete_sous_programmes:		FUNC ID arguments PP type PV
							|PROC ID arguments PV
;

arguments:	PG liste_parametres PD
			|E
;

liste_parametres:	liste_identificateurs PP type
					|liste_parametres PV liste_identificateurs PP type
;

instruction_composee:	AG instruction_optionnelles AD
;

instruction_optionnelles:	liste_instructions
							|/*vide*/
;

liste_instructions:	instruction
					|liste_instructions PV instruction
;												

instruction:	variable OPAFFECT expression
				|instruction_proc
				|instruction_composee
				|IF expression THEN AG instruction AD
				|IF expression THEN AG instruction AD AG instruction AD
				|REPEAT instruction UNTIL expression
;

variable:	ID
;

instruction_proc:	ID
					|ID PG liste_expressions PD
;

liste_expressions:	expression
					|liste_expressions VR expression
;

expression:	expression_simple
			|expression_simple OPREL expression_simple
;

expression_simple:	terme
					|signe terme
					|expression_simple OPADD_OR terme
					|expression_simple OPADD_PLUS terme
					|expression_simple OPADD_MOINS terme
;

terme:	facteur
		|terme OPMUL facteur
		|facteur PUISSANCE terme
;

facteur:	ID
			|ID PG liste_expressions PD
			|NB
			|PG expression PD
			|NOT facteur
;

signe:	OPADD_PLUS
		|OPADD_MOINS
;																													
%%




int yyerror(char *s) {printf("%s \n",s);}
int yywrap(){return 1;}
int main( )
{ 
extern FILE* yyin;
yyin = fopen( "fich.txt","r" );
if (yyparse()==0) printf("PROGRAMME PASCAL VALIDE : RESPECTE LE GRAMMAIRE \n");
	else printf("PROGRAMME PASCAL INVALIDE : NE RESPECTE PAS LE GRAMMAIRE \n");

}
