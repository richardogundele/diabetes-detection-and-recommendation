ask(Patient, Query):-  %a function that triggers the questions the system ask the user
    write(Patient), write(Query),
    read(N),
    ((N == yes;N==y) -> assert(yes(Query)) ; assert(no(Query)), fail). %add the clause to the database
:- dynamic yes/1,no/1.	

check(P,S) :-
    (yes(S) -> true ;
    (no(S) -> fail ; ask(P,S))).

undo :- retract(no(_)),fail.  %remove the clause from the database
undo :- retract(yes(_)),fail. 
undo.

% symptoms rules : Predicates
symptoms(Patient, wound1):-
    check(Patient, " do you have any type of wound healing solely (y/n) ?").
symptoms(Patient, weight_loss1):-
    check(Patient, " do you experience weight loss (y/n) ?").   
symptoms(Patient, thirst_and_hunger1):-
    check(Patient, " Are you very thirsty and hungry lately (y/n) ?").
symptoms(Patient, fatigue1):-
	check(Patient, " do you experience fatigue and weakness (y/n) ?").   
symptoms(Patient, dizziness1):-
    check(Patient, " do you experience dizziness (y/n) ?").   
symptoms(Patient, fever1):-
    check(Patient, " do you have fever (y/n) ?").
symptoms(Patient, age_below_25):-
    check(Patient, " Are you below 25 years of age (y/n) ?").   
symptoms(Patient, age_above_25):-
    check(Patient, " Are you above 25 years of age (y/n) ?").
symptoms(Patient, urinate):-
    check(Patient, " do you urinate more than normal (y/n) ?").
symptoms(Patient, wound2):-
    check(Patient, " do you have any type of wound healing solely (y/n) ?").
symptoms(Patient, weight_loss2):-
    check(Patient, " do you experience weight loss (y/n) ?").   
symptoms(Patient, thirst_and_hunger2):-
    check(Patient, " Are you very thirsty and hungry lately (y/n) ?").
symptoms(Patient, fatigue2):-
	check(Patient, " do you experience fatigue and weakness (y/n) ?").   
symptoms(Patient, dizziness2):-
    check(Patient, " do you experience dizziness (y/n) ?").   
symptoms(Patient, fever2):-
    check(Patient, " do you have fever (y/n) ?").
symptoms(Patient, alcohol):-
    check(Patient, " do you take alcohol (y/n) ?").

symptoms_types(Patient, type1_diabetes):- %here is a production rule that checks the predicates
    symptoms(Patient, fever1),
    symptoms(Patient, fatigue1),
    symptoms(Patient, weight_loss1),
    symptoms(Patient, thirst_and_hunger1),
    symptoms(Patient, dizziness1),
    symptoms(Patient, wound1),
	symptoms(Patient, age_below_25).

symptoms_types(Patient, type2_diabetes):-
    symptoms(Patient, fatigue2),
    symptoms(Patient, weight_loss2),
    symptoms(Patient, thirst_and_hunger2),
    symptoms(Patient, dizziness2),
    symptoms(Patient, wound2),
	symptoms(Patient, fever2),
    symptoms(Patient, age_above_25).

recommendation(type1_diabetes):-
    nl,
    write("->See a General Practictioner as soon as possible to develop a healthy diet plan"),nl,
    write("->Stop consumption of processed foods, alcohol, sugary drinks"),nl.

recommendation(type2_diabetes):-
    nl,
    write("->I recommend you start eating lean protein, low fat diary and higher fiber"),nl,
    write("foods as low-calorie meal plan will increase the insulin level"),nl,
    write("->Get alot of exercise and see the GP for drug recommendation").

start:-             %fire engine of the system
    write("What is your name?/name of patient "),
    read(Patient),
    symptoms_types(Patient, Diabetestype),
    write(Patient), write("you most likely have "), write(Diabetestype), write("symptoms."),
    nl,
    recommendation(Diabetestype),
    nl.

start :-
     write("I can't find any diabetes symptoms"),nl.
