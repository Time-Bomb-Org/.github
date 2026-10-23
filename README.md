# Time Bomb Org

Organisation du projet Time Bomb Mobile. La présentation publique est disponible sur le [profil de l’organisation](profile/README.md).

## Contribuer

Après avoir cloné ce dépôt, active le contrôle local des messages de commit :

```sh
mise run setup
```

Cette commande est à lancer une fois dans chaque clone. Elle configure le hook
`commit-msg` fourni par `.githooks/`. Les nouveaux commits doivent suivre le
format `type(scope): description`, par exemple `feat(core): add round timeout`.
Le scope est facultatif. Types acceptés : `feat`, `fix`, `docs`, `style`,
`refactor`, `perf`, `test`, `build`, `ci`, `chore` et `revert`. Les commits de
merge générés par Git sont acceptés tels quels.

## Environnement de développement

Installer mise **2026.10.17**, Git et Bash. Sous Windows natif, utiliser Git Bash
(Git for Windows) ; sous WSL, installer mise et Git Linux dans la distribution.
Si `MISE_BASH_PATH` est défini, il doit pointer vers Git Bash, pas le lanceur WSL.
Examiner `mise.toml`, puis lancer :

```sh
mise trust
mise run doctor
mise run setup
```

Le setup est idempotent et active uniquement les hooks déjà fournis dans ce
clone, y compris dans un worktree Git. Aucun SDK applicatif n'est installé et
aucun lockfile vide n'est ajouté. `mise tasks ls` liste les tâches.

Validation à effectuer avant fusion : `bash tests/tooling/setup.sh`, puis
`mise run doctor` et `mise run setup` dans un clone de test, sur les plateformes
concernées. Cette PR attend les tests et la validation de Thomas.
