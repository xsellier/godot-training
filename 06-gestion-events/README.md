# Gestion des events

## Énoncé

Dans cet exercice on va apprendre a gérer les inputs utilisateur et a capturer les events et les marquer comme tels.
C'est-à-dire empêcher la propagation d'un event lorsqu'il a été traité.

* Lorsque j'appuie sur la touche K du clavier il doit y avoir écrit:

`Bonjour, vous avez appuyé sur K`

* Lorsque j'appuie sur la touche O du clavier il doit y avoir écrit:


`Bonjour, avez-vous appuyé sur la touche O ?`
* Lorsque j'appuie sur une autre touches du clavier, il doit y avoir écrit:

`Bonjour, je ne reconnaîs pas la touche qui a été pressée`
* Lorsque j'appuie simultannément sur les touches Ctrl puis K, il doit y avoir écrit:

`Bonjour, comment allez vous ?`

* Lorsque j'appuie simultannément sur les touches Ctrl puis O, il doit y avoir écrit:

`Content de voir que vous allez bien !`

* Lorsque je clique avec la souris, bouton de gauche ou de droite, cela doit afficher:

`Arrêtez ça chatouille !`

## Correction

[Voir la correction](./correction)

## Exécuter le script

```shell
godot -path correction/
```
