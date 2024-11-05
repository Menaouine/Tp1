:- dynamic task/4.

% Création d'une tâche
create_task(ID, Description, Assignee) :-
    \+ task(ID, _, _, _),  % Vérifie que l'ID n'existe pas déjà
    assertz(task(ID, Description, Assignee, false)),  % Ajoute la tâche avec un statut de non-complété
    format('Task created: ~w.~n', [ID]).  % Message de confirmation

% Assignation d'une tâche à un nouvel utilisateur
assign_task(ID, NewAssignee) :-
    retract(task(ID, Description, _, Status)),  % Retire la tâche pour la mettre à jour
    assertz(task(ID, Description, NewAssignee, Status)),  % Ajoute la tâche mise à jour
    format('Task ~w assigned to: ~w.~n', [ID, NewAssignee]).  % Message de confirmation

% Marquer une tâche comme complétée
mark_completed(ID) :-
    retract(task(ID, Description, Assignee, _)),  % Retire la tâche existante
    assertz(task(ID, Description, Assignee, true)),  % Marque la tâche comme complétée
    format('Task ~w marked as completed.~n', [ID]).  % Message de confirmation

% Afficher toutes les tâches
display_tasks :-
    forall(task(ID, Description, Assignee, Status),
           (format('Task ~w:~n- Description: ~w~n- Assignee: ~w~n- Completion status: ~w~n~n',
                   [ID, Description, Assignee, Status]))).

% Afficher les tâches assignées à un utilisateur spécifique
display_tasks_assigned_to(Assignee) :-
    format('Tasks assigned to ~w:~n', [Assignee]),
    forall(task(ID, Description, Assignee, Status),
           (format('Task ~w:~n- Description: ~w~n- Completion status: ~w~n',
                   [ID, Description, Status]))).



