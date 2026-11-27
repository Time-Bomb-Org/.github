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

## Titres de PR et notes de release

Le workflow partagé `check-jira-pr-title.yml` exige un titre de PR de la forme
`type(scope): description [CLÉ-JIRA]`, par exemple
`feat(core): handle timeout [SCRUM-123]`. Le type suit la même règle que le
hook `commit-msg`.

Le workflow partagé `label-pr.yml` pose le label de type déduit de ce titre et
retire les autres labels de type quand le titre change. Il ne touche à aucun
autre label et ignore les PR Dependabot ou portant le label `dependencies`.

| Type | Label |
|---|---|
| `feat` | `enhancement` |
| `fix` | `fix` |
| `docs` | `documentation` |
| `ci`, `build` | `ci/cd` |
| `test` | `test` |
| `revert` | `revert` |
| `style`, `refactor`, `perf`, `chore` | aucun |

Les labels doivent déjà exister dans le dépôt. Pour activer l'étiquetage, ajoute
`.github/workflows/label-pr.yml` :

```yaml
name: PR type label

on:
  pull_request:
    types: [opened, edited, reopened]

permissions:
  pull-requests: write

jobs:
  label:
    uses: Time-Bomb-Org/.github/.github/workflows/label-pr.yml@main
```

Pour classer les notes de release générées par GitHub, copie
[`templates/release.yml`](templates/release.yml) tel quel dans
`.github/release.yml`. GitHub ne lit pas ce fichier depuis ce dépôt : chaque
dépôt garde sa copie, à garder identique au modèle.
