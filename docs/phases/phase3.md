# Phase 3: User Authentication and Associations

## Rails
### Models
* Preview belongs to user
* User(email, password_digest, session_token) has_many previews/comments
### Controllers
* Users(new, create, show)
* Sessions(new, create, destroy)
### Views
* sessions/new.html.erb
* users/new.html.erb
* users/show.json.jbuilder
## Backbone
### Models
* User with previews function
### Collections
* Users
### Views
* UserShow with
* previewItem subviews
## Gems/Libraries
* Filepicker
