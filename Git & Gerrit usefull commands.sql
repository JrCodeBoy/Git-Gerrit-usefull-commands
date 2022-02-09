**************** ************** *********************************************************************************
***** ***************** ORDEN DE IMPLEMENTACION ***** *****************

_________ - DEV, AWS-SIT, SIT, UAT1, UAT2, PROD - ________ 

***** *****************   ************     **************************************
********************** CIRCUITO DE UN CAMBIO A MIGRAR **************
1- COMMIT APROBADO
2- MERGE A TEST
3- SE APRUEBA EL MERGE A TEST 
4- DEPLOYAR 
5- FLYWAY EJECUTA OK // SI EJECUTA CON ERRORE, REVISAR SI PINCHO MI CAMBIO O EL DE OTRA PERSONA Y REPORTAR
6- MERGE AL MASTER
7- PASR AL RELEASE POR CHERRYPICK (SIEMPRE Y CUANDO TE HAYAS PASADO DE LA FECHA DE FREEZADO DE CODIGO)

***** *****************   ************     **************************************

/* GENERO EL COMMIT SOBRE MI NUEVO BRANCH */ 
git STATUS ------------>>> bajar o subir
GIT PULL
git reset --hard origin/feature/STORY-*******

/* GIT CHECKOUT  POSICIONA TU DIRECTORIO LOCAL SOBRE LA RUTA QUE SIGA AL CHECKOUT */
git checkout feature/STORY-

/* MOVER LOS FILES A MIGRAR A SU RECPECTIVA RUTA */
git add .
git commit -m "STORY-*************" 
git push origin HEAD:refs/for/feature/STORY- --SIEMPRE ES EL ULTIMO PASO y PONES LA RUTA HACIA DONDE QUERES MOVER TU CAMBIO --


************** ******************************** ************** ************************************************
***** *****************   ************     **************************************
    --MERGE al TEST
    git reset --hard origin/test
    git checkout test (SIEMPRE TE PARAS DONDE SE QUIEREN METER LOS CAMBIOS)
    git pull
    --VERIFICAR QUE EL DIRECTORIO ES EL QUE FIGURA EN LA COLUMNA BRANCH DEL GERRIT
    git merge origin/feature/STORY- –-no-ff –m “Merge STORY- into TEST”
    git push origin HEAD:refs/for/test --SIEMPRE ES EL ULTIMO PASO y PONES LA RUTA HACIA DONDE QUERES MOVER TU CAMBIO

**************** ************** *********************************************************************************
***** *****************   ************     **************************************

*****************   ************     *************************************
git reset --hard origin/release/2021.07.0

--MERGE al MASTER
git reset --hard origin/master
git checkout master
git pull
git merge origin/feature/STORY- –-no-ff –m “Merge STORY- into Master”
git push origin HEAD:refs/for/master --SIEMPRE ES EL ULTIMO PASO y PONES LA RUTA HACIA DONDE QUERES MOVER TU CAMBIO --

*****************   ************     **************************************
**************** ************** *********************************************************************************

## resolve conflicts:	
git checkout –-ours . ## mantiene lo del master / test
git checkout --theirs 	 ## PREDOMINA lo del FEATURE/branch (PREDOMINA BRANCH)
git add .
git commit –m “Merge DEF-*****”

**************** ************** *********************************************************************************
*****************   ************     **************************************

Para incluir UN CAMBIO en el commit anterior
git commit --amend
ESC :q ENTER
:wq --> guarda el msg que modificamos


*****************   ************     **************************************
************* * *****
Por que puedo tener un Merge sin estado en Gerrit?
    whenever you do git push, it will wait for code review; if you then do another git push, then gerrit links these changes
    and creates a dependency
    what you need to do is: After you run git push, and you are waiting for code review

    you should run git reset (please confirm the exact syntax with sb from your team)
    once master (or test) branch is reset to its remote state you can run another merge.
	and then git push again...

*****************   ************     **************************************
**************** ************** *********************************************************************************