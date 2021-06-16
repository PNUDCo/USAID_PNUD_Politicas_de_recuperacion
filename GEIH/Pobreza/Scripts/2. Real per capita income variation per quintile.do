	* Author: Omar Francisco Alvarado                               *
	* Email: omar.alvarado@undp.org	                                *			    
	* Area:   Human Development Studies-PNUD CO COL	                *		
	* Fecha:  Mayo 06 2021					                        *		
	* Purpose of the do file: compute real income growth per        *
	*quintile by capital cities, national, urban and rural                                                    *
	*data in: Hogares.dta personas.dta pobreza 2019 - 2020          * 				                                   
	*****************************************************************
clear
set more off 

global path "C:\Users\alvar\OneDrive - United Nations Development programme\Datos"
global path2 "C:\Users\alvar\OneDrive - United Nations Development programme\Datos\pobreza por ingresos\outputs"


	global x "19 20"
*Esta parte es solo para ciudades capitales y otras areas urbanas
*estandarizo nombres para que me coincidan con la matriz de deflactores
	foreach y of global x {
	use "$path\pobreza por ingresos\hogares_20`y'.dta" 
	replace dominio="RESTOURBANO" if dominio=="RESTO URBANO"
	replace dominio="MONTERIA" if dominio=="MONTERÍA"
	keep if dominio!="RURAL"|dominio!="QUIBDO" /*me quedo con todos menos lo rural pues no tengo deflactores particulares para esa zona*/
    cap encode dominio, gen(domnum) /*genero una variable numérica para poder volver matriz y queda con el label*/
	save "$path\pobreza por ingresos\hogares_20`y'.dta", replace /*guardo la variable numdom en la base de hogares para el proceso posterior*/
	keep dominio domnum
	duplicates drop *, force /*me quedo solo con los dominios para pegarlos en la base de deflactores*/
	tab domnum
	save"$path\pobreza por ingresos\dominios`y'.dta", replace
	}
*importo deflactores desde excel y genero una matriz con los valores para usar en el loopear
import excel "$path\pobreza por ingresos\deflactores ciudades capitales_basedic2018.xls", sheet("deflactores") firstrow clear
save "$path\deflactores.dta", replace /*la serie del IPC utilizada para calcular los deflactores por ciudad se generan en el sistema de consulta dinámica del dane, en este caso se lleva todo a precios de diciembre de 2018*/
merge m:1 dominio using "$path\pobreza por ingresos\dominios20.dta", keepusing(domnum)
drop if _merge==1|_merge==2 /*solo me interesan los cruces con los dominios de interes*/
drop _merge
drop dominio /*borro la variable string*/
sort año mes domnum
list *
mkmat *, mat(deflac) /*genero una matriz para poder usarla luego en el loop*/
mat list deflac


****************************************************
* Choque Covid-19
****************************************************
*replace empleo_2020=(temp<=ABS[`m',1]) if dpto==11 & mes==`m' & pet==1  

	*Lo primero es sobre 2019 traer el ingpcug_cte20 a precios de 2020 para las variaciones por quintil
	
levelsof mes, local(mes) /*genero local con cada mes*/
levelsof domnum,local(domin) /*genero local con cada dominio*/

/*usando la matriz de deflactores generada previamente aplico deflactarores para 2019 y 2020 para cada
ciudad capital y el dominio otra areas urbanas*/
	foreach y of global x {
	  clear
	  use "$path\pobreza por ingresos\hogares_20`y'.dta" 
	  cap gen ingpcug_cte18=.
	  cap gen año=20`y'
	  destring mes año, replace
	  keep if dominio!="RURAL"
			foreach m of local mes{
			foreach d of local domin {    
			replace ingpcug_cte18=ingpcug/deflac[`m',3]  if mes==`m'&año==20`y'&domnum==`d'
			
									}
							}
	save "$path\pobreza por ingresos\hogares_20`y'ciudades.dta", replace 
						}

	*genero las bases por ciudades y otras areas urbanas con un collapse
	*el loop genera los quintiles para cada dominio y hace collapse para cada una de las ciudades capitales
	clear all
	global x "19 20"
	foreach y of global x { 
	    foreach d of local domin {  
	use "$path\pobreza por ingresos\hogares_20`y'ciudades.dta"
	gen year=20`y' /*genero variable año para el collapse*/
	quantiles ingpcug if domnum==`d' [iw=fex_c], gen (quintil_`d') n(5) s /*genero quintil individual para cada dominio*/
	tab quintil_`d' [iw=fex_c]
	collapse (mean) year ingpcug_cte18 ingpcug if domnum==`d' [iw=fex_c], by(domnum quintil_`d')
	rename quintil_`d' quintil
	save "$path2\quintil\quintil_20`y'_`d'.dta", replace
								}
							}
	*como tengo bases separadas para cad dominio debo pegarlas 
	*pego 2019 y 2020 y exporto a excel para esto genero un archivo temporal para sobre este pegar todos los archivos

clear

cd "$path2\quintil"
    clear
    local files : dir . files "*.dta" /*con esto cojo todos los archivos de la ruta y les aplicao el loop*/
	
tempfile building /*con esto genero un temporal para hacer el append de todos los dominios*/
save `building', emptyok  

foreach f of local files {
    use `"`f'"', clear
    append using `building'
	duplicates drop
    save `"`building'"', replace
	}

save "$path2\quintilestodosciudad.dta", replace
export excel using "$path2\quintilestodosciudad.xls", firstrow(variables) replace

