:- dynamic task/4.

% Cr�ation d'une t�che
create_task(ID, Description, Assignee) :-
    \+ task(ID, _, _, _),  % V�rifie que l'ID n'existe pas d�j�
    assertz(task(ID, Description, Assignee, false)),  % Ajoute la t�che avec un statut de non-compl�t�
    format('Task created: ~w.~n', [ID]).  % Message de confirmation

% Assignation d'une t�che � un nouvel utilisateur
assign_task(ID, NewAssignee) :-
    retract(task(ID, Description, _, Status)),  % Retire la t�che pour la mettre � jour
    assertz(task(ID, Description, NewAssignee, Status)),  % Ajoute la t�che mise � jour
    format('Task ~w assigned to: ~w.~n', [ID, NewAssignee]).  % Message de confirmation

% Marquer une t�che comme compl�t�e
mark_completed(ID) :-
    retract(task(ID, Description, Assignee, _)),  % Retire la t�che existante
    assertz(task(ID, Description, Assignee, true)),  % Marque la t�che comme compl�t�e
    format('Task ~w marked as completed.~n', [ID]).  % Message de confirmation

% Afficher toutes les t�ches
display_tasks :-
    forall(task(ID, Description, Assignee, Status),
           (format('Task ~w:~n- Description: ~w~n- Assignee: ~w~n- Completion status: ~w~n~n',
                   [ID, Description, Assignee, Status]))).

% Afficher les t�ches assign�es � un utilisateur sp�cifique
display_tasks_assigned_to(Assignee) :-
    format('Tasks assigned to ~w:~n', [Assignee]),
    forall(task(ID, Description, Assignee, Status),
           (format('Task ~w:~n- Description: ~w~n- Completion status: ~w~n',
                   [ID, Description, Status]))).



