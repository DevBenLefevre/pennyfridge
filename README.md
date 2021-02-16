# README

## User Story

Cette application a pour but de répondre à la problématique suivante : "J'attends des amis à dîner mais je n'ai pas le temps de faire des courses. Sachant ce que j'ai dans mon frigo, qu'est-ce que je peux préparer ?"

Pour utiliser l'application, il suffit de rentrer dans l'input prévu à cet effet, la liste des ingrédients qui sont présents dans notre frigo, séparés par des "," ou en tapant sur la touche "Entrée".

Ensuite, au choix, on a la possibilité de choisir une note minimale sur la recette, allant de 1 à 5.

Pour finir, cliquer sur "Rechercher" et une liste des recettes contenant au moins un des aliments désirés apparaît.

Nous pourrons discuter avec plaisir des possibilités d'améliorations/évolution.

## Dev-local

Pour lancer le projet en local :

* docker-compose up (démarrer le container web et db, en postgresql)
* rails db:seed

## Déploiement

Le projet est déployé sur heroku : https://pennyfridge.herokuapp.com/

## Interface

Feel free to add React ;-)

## Database

La strucuture est volontairement simple, pour éviter les `JOIN` coûteux.

```
ActiveRecord::Schema.define(version: 2021_02_15_155126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.bigint "recipe_id"
    t.string "name"
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.index ["recipe_id"], name: "index_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "author"
    t.integer "rate"
    t.string "difficulty"
    t.string "budget"
    t.string "prep_time"
    t.string "total_time"
    t.integer "people_quantity"
    t.string "author_tip"
    t.string "name"
    t.string "tags", array: true
    t.string "image"
    t.integer "nb_comments"
    t.string "cook_time"
    t.datetime "created_at", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.integer "ingredients_count"
  end

end

```
