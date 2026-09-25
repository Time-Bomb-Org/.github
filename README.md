# Time Bomb Org

Organisation du projet Time Bomb Mobile. La présentation publique est disponible sur le [profil de l’organisation](profile/README.md).

## Contribuer

Après avoir cloné ce dépôt, active le contrôle local des messages de commit :

```sh
make setup
```

Cette commande est à lancer une fois dans chaque clone. Elle configure le hook
`commit-msg` fourni par `.githooks/`. Les nouveaux commits doivent suivre le
format `type(scope): description`, par exemple `feat(core): add round timeout`.
Le scope est facultatif. Types acceptés : `feat`, `fix`, `docs`, `style`,
`refactor`, `perf`, `test`, `build`, `ci`, `chore` et `revert`. Les commits de
merge générés par Git sont acceptés tels quels.
