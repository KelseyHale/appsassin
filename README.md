![Build Status](https://codeship.com/projects/c0981aa0-0aea-0133-0d5c-2696e3e4b295/status?branch=master)![Code Climate](https://codeclimate.com/github/KelseyHale/appsassin.png)

* Ruby version 2.0.0

Appsassin is a facilitator for the live action game "Assassin" (sometimes called "Gotcha!").

![alt](http://media.tumblr.com/tumblr_m9k39jGw0F1qc7y62.gif)

Appsassin is a Ruby on Rails app that leverages a PostgreSQL database for the back end and a Materialize front end. I integrated the Twilio API to keep players updated about the game through texts.

Visit Appsassin at the following URL: http://appsassin.herokuapp.com/

---
**Technical Challenges**

 - Database relationship complexity
    - When a user of the site joins a game they become both a "player" and a "target"
    - Users can join multiple games and as such have the potential to inherit multiple targets at one time
    - After elimination the player must be marked as "inactive"

    *Solution:* Created database relationships that handle complexity of user relationships (users = both "player"                   and "target")

 - Integration of Twilio with correct timing
    - Players should be notified when they have received their target at the start of a new round
    - Players should be notified of the game winner when the game is over

    *Solution:* Employed a callback to integrate Twilio to ensure users receive updates about the game status


=======
---

**Screenshots**

![alt](http://i.imgur.com/6gZUaC0.png)
![alt](http://i.imgur.com/HCYolJc.png)
![alt](http://i.imgur.com/Y5RH76Q.png)
![alt](http://i.imgur.com/Pgeixiu.png)
![alt](http://i.imgur.com/NeriI5Pm.png)
