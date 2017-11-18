%Funcionarios y tipos de Funcionarios
funcionario(nombre('Camila'), contrato('tco'), categoria('titular')).
funcionario(nombre('Valentina'), contrato('tco'), categoria('asociado')).
funcionario(nombre('Rodrigo'), contrato('tco'), categoria('asistente')).
funcionario(nombre('Aluna'), contrato('tco'), categoria('auxiliar')).

funcionario(nombre('Daniel'), contrato('hc'), categoria('auxiliar')).
funcionario(nombre('Diego'), contrato('hc'),categoria('asistente')).
funcionario(nombre('marcela'), contrato('hc'),categoria('asociado')).
funcionario(nombre('David'), contrato('hc'),categoria('titular')).

funcionario(nombre('Juan'), contrato('honorarios'), categoria('asociado')).
funcionario(nombre('pedro'), contrato('honorarios'), categoria('titular')).
funcionario(nombre('raul'), contrato('honorarios'), categoria('asistente')).
funcionario(nombre('leidy'), contrato('honorarios'), categoria('auxiliar')).

funcionario(nombre('Alejandro'), contrato('planta'), categoria('auxiliar')).
funcionario(nombre('Felipe'), contrato('planta'), categoria('titular')).
funcionario(nombre('Fernando'), contrato('planta'), categoria('asistente')).
funcionario(nombre('Guillermo'), contrato('planta'), categoria('asociado')).

funcionario(nombre('Angie'), contrato('mto'), categoria('asociado')).
funcionario(nombre('Karen'), contrato('mto'), categoria('titular')).
funcionario(nombre('alex'), contrato('mto'), categoria('asistente')).
funcionario(nombre('Dayana'), contrato('mto'), categoria('auxiliar')).


%porcetaje adigional sobre el pago al funcionario
adicional(0.15, contrato('tco')).
adicional(0.20, contrato('hc')).
adicional(0.25, contrato('honorarios')).
adicional(0.10, contrato('mto')).
adicional(0.08, contrato('planta')).

%horas de trabajo semanales de un funcionario
horas_semanales(contrato('honorarios'), 8).
horas_semanales(contrato('hc'), 16).
horas_semanales(contrato('mto'), 20).
horas_semanales(contrato('planta'), 40).
horas_semanales(contrato('tco'), 40).

%Semanas totales segn tipo de semestre
tipo_semestre('normal',18).
tipo_semestre('vacacional',4).

%sueldo asignados a funcionarios por contrato honorarios y categorias especificas

sueldo_basico(contrato('honorarios'), categoria('auxiliar'), 20000).
sueldo_basico(contrato('honorarios'), categoria('asistente'), 50000).
sueldo_basico(contrato('honorarios'), categoria('titular'), 100000).
sueldo_basico(contrato('honorarios'), categoria('asociado'), 150000).

%sueldo asignados a funcionarios por contrato planta y categorias especificas

sueldo_basico(contrato('planta'), categoria('auxiliar'), 20000).
sueldo_basico(contrato('planta'), categoria('asistente'), 50000).
sueldo_basico(contrato('planta'), categoria('titular'), 100000).
sueldo_basico(contrato('planta'), categoria('asociado'), 150000).

%sueldo asignados a funcionarios por contrato hc y categorias especificas

sueldo_basico(contrato('hc'), categoria('auxiliar'), 20000).
sueldo_basico(contrato('hc'), categoria('asistente'), 50000).
sueldo_basico(contrato('hc'), categoria('titular'), 100000).
sueldo_basico(contrato('hc'), categoria('asociado'), 150000).

%sueldo asignados a funcionarios por contrato tco y categorias especificas

sueldo_basico(contrato('tco'), categoria('auxiliar'), 20000).
sueldo_basico(contrato('tco'), categoria('asistente'), 50000).
sueldo_basico(contrato('tco'), categoria('titular'), 100000).
sueldo_basico(contrato('tco'), categoria('asociado'), 150000).

%sueldo asignados a funcionarios por contrato mto y categorias especificas

sueldo_basico(contrato('mto'), categoria('auxiliar'), 20000).
sueldo_basico(contrato('mto'), categoria('asistente'), 50000).
sueldo_basico(contrato('mto'), categoria('titular'), 100000).
sueldo_basico(contrato('mto'), categoria('asociado'), 150000).


%Reglas
sumar_lista([], 0).
sumar_lista([H|T], Suma):- sumar_lista(T, Suma1), Suma is H + Suma1.

%Calculo del salario total de un empleado
salario_total(funcionario(nombre(X), Y, Z), Semestre, Total) :- funcionario(nombre(X),Y,Z),sueldo_basico(Y, Z, B), adicional(Bono, Y),tipo_semestre(Semestre,S),horas_semanales(Y, H), Total is round((B*H*S)*(1+Bono)).
%calculo total de la nomina
totalSemestre(Tipo, Valor) :- listaNominas(Lista, Tipo),  sumar_lista(Lista, Valor).
%calculo de las listas de las nominas
listaNominas(Lista, Tipo) :- findall( Valor, salario_total(funcionario(nombre(_),_,_), Tipo, Valor), Lista ).
