:- dynamic task/4.

create_task(ID, Description, Assignee) :-
    \+ task(ID, _, _, _),  
    assertz(task(ID, Description, Assignee, false)),  
    format('Task created: ~w.~n', [ID]).  

assign_task(ID, NewAssignee) :-
    retract(task(ID, Description, _, Status)),  
    assertz(task(ID, Description, NewAssignee, Status)),  
    format('Task ~w assigned to: ~w.~n', [ID, NewAssignee]). 

mark_completed(ID) :-
    retract(task(ID, Description, Assignee, _)),  
    assertz(task(ID, Description, Assignee, true)), 
    format('Task ~w marked as completed.~n', [ID]).  


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



