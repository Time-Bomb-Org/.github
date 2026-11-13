# Migration du setup vers mise

Ticket : [SCRUM-58](https://time-bomb.atlassian.net/browse/SCRUM-58).

PR préparée sans exécution de tests par l'agent, à la demande de Thomas.
Validation à renseigner après son retour : Linux, macOS, Windows Git Bash et WSL.

Commandes : `bash tests/tooling/setup.sh`, `mise tasks ls`, `mise run doctor`,
`mise run setup` dans un clone de test. Contrôler l'idempotence, les hooks
inchangés, les chemins avec espaces et les worktrees. Aucun test n'a été lancé
pour ce lot ; ne pas assimiler la préparation de la PR à une validation.

## Reprise du 13 novembre 2026

Le pilote et la CI core sont validés ; PR core #19 et #20 fusionnées.
Le workflow `Mise setup validation` prépare les preuves Linux/macOS/Windows
Git Bash/WSL : contrats shell existants, vraies tâches mise doctor/setup,
idempotence, conservation des hooks, clone autonome, worktree et enfant d'un
orchestrateur factice. Doctor ne doit pas changer la configuration des hooks ;
le setup enfant ne doit pas exécuter celui du parent ni changer sa configuration.
Les dépendances des actions sont référencées par SHA. Aucun outil applicatif
n'est installé.

Thomas déclenche la première validation en sortant la PR du brouillon
(`gh pr ready`), événement `ready_for_review`. Le workflow pourra être relancé
depuis Actions après sa première exécution, ou avec `gh run rerun <id>`.
Le déclenchement manuel par nom de fichier peut nécessiter sa présence dans
la branche par défaut. Aucun test ni workflow n'a été lancé par l'agent pour
ce lot. Les quatre plateformes restent à valider avant fusion.

Pour reproduire localement dans un checkout de test :
`bash scripts/validate-mise.sh` (mise 2026.10.17, Git et Bash nécessaires).
