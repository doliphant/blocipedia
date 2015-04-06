Ruby 2.2.0
Rails 4.2.0

My second project with Bloc.io. This is where things started to click for me. I was able to implement more new ideas than on my first project due to a better understanding of the big picture. ActiveRecord, model relationships, controller actions, views, you name it. The project site itself is bare bones function focused and demonstrates my struggles with front end design, but my personal highlights include working with a joins table, policy with pundit, and really getting to know the ActiveRecord Relationships that Rails can obfuscate on basic projects.

Notes:
  1. Private wikis can only be created and viewed by Premium members. This is true even when a public user is a collaborator on a wiki.
  2. Private really is private. Private wikis are not visible to other premium users unless they are collaborators.
  3. Upgrading to Premium is done with [Stripe](https://stripe.com/). It is deliberately set to test mode. The upgrade itself occurs when payment is processed. 

Viewable on heroku: [Blocipedia](https://doliphant-blocipedia.herokuapp.com/)
