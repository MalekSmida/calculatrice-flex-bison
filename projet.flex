%{
#include<stdio.h>
#include<stdlib.h>
#include "projet.tab.h"

%}

blanc [ \t]+
lettre [a-zA-Z]
chiffre  [0 – 9]
id  lettre (lettre | chiffre)*
nb  chiffre+

%%

{blanc}	{}
"+"		{return (OPADD_PLUS);}
"-" 	{return (OPADD_MOINS);}
"or"	{return (OPADD_OR);}

"<="	{return (OPREL);}
"=" 	{return (OPREL);}
">"		{return (OPREL);}
">="	{return (OPREL);}
"<"		{return (OPREL);}
"<>"	{return (OPREL);}

"div"	{return (OPMUL);}
"mod"	{return (OPMUL);}
"and"	{return (OPMUL);}

"*"		{return (OPMUL);}
"/"		{return (OPMUL);}

"**"	{return (PUISSANCE);}
"("		{return (PG);}
")"		{return (PD);}
"\n"	{return (FIN);}
"{"		{return (AG);}
"}"		{return (AD);}

":="	{return (OPAFFECT);}

"program"	{return (PROGRAM);}
 
" id"	{return(ID) ;} 
"var"	{return(DEC) ;}
"Int"	{return (TYPE) ;}
"LongInt"	{return (TYPE) ;}
 " func "	{return(FUNC) ;}
"proc "		{return(PROC) ;}
"if"		{return(IF) ;}
"then"		{return(THEN) ;}
"repeat"	{return(REPEAT) ;}
"until"		{return(UNTIL) ;}
"not"	{return(NOT) ;}
"nb"	{return(NB) ;}
"id"	{return(ID) ;}
";"		{return(PV) ;}
":"		{return(PP) ;}
","		{return(VR) ;}

"E"		{return(E);}
"."		{return(POINT);}

%%
