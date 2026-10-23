# Migration du setup vers mise

Ticket : [SCRUM-58](https://time-bomb.atlassian.net/browse/SCRUM-58).

PR préparée sans exécution de tests par l'agent, à la demande de Thomas.
Validation à renseigner après son retour : Linux, macOS, Windows Git Bash et WSL.

Commandes : `bash tests/tooling/setup.sh`, `mise tasks ls`, `mise run doctor`,
`mise run setup` dans un clone de test. Contrôler l'idempotence, les hooks
inchangés, les chemins avec espaces et les worktrees. Aucun test n'a été lancé
pour ce lot ; ne pas assimiler la préparation de la PR à une validation.
