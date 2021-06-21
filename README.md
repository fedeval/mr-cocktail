# Mr. Cocktail #

## Introduction ##

I have built this app initially as part of an exercies to practice Ruby on Rails and CRUD concepts during the LeWagon Fullstack web development bootcamp and made some improvements after graduating.

The app is a repository of cocktail recipes where users can - after signing up and logging in - perform the following actions:
* Create a cocktail recipe
* Edit a cocktails recipe they have created
* Delete a cocktail recipe they have created
* Browse and/or search all cocktail recipes
* Open a cocktail details page where they can review and mark as favorite a cocktail
* Manage their cocktail creations and favorites from a dashboard page

A version of the app hosted on Heroku is available at [https://mr-cocktail-fedeval.herokuapp.com/](https://mr-cocktail-fedeval.herokuapp.com/)

---
## System Dependencies ##

The app is meant to work with the following requirements:
```
- Ruby v2.6.6p146 (2020-03-31 revision 67876) [x86_64-darwin19]
- Rails v6.0.3.4
- Node v.16.3.0
- Postgres v.13.3
```
---
## Setup ##

### Environment variables ###
 
This app relies on Cloudinary to host images, thus to be able to run it on your machine you'll need to create a Cloudinary account at [https://cloudinary.com/](https://cloudinary.com/) and add your `CLOUDINARY_URL` as an environment variable in a `.
env` which by default will be ignored by git as already added to a `.gitignore` file.

### Gems and dependencies ###

After cloning the repo using `git clone git@github.com:fedeval/mr-cocktail.git`, `cd` into the folder and install all the project gems and dependencies using bundler and yarn. Run:

```
bundle install
yarn install
````

### Database ###

To create the postgres db and run all migrations use the command:
```
rails db:create db:migrate
```

The folder includes a seed file that creates a few test users and some database instances of cocktails by using a free API offered by [https://www.thecocktaildb.com/](https://www.thecocktaildb.com/). If you wish to use these seeds just run `rails db:seed` after you have created the db and run all migrations.

---
### How to use ###

Once you have completed the setup, just run `rails server` or `rails s` in your terminal from the root folder. The app will then be available on [http://localhost:3000/](http://localhost:3000/).

