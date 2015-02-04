# Phase 4: Comments on previews

## Rails
### Models
* Comment(user_id, preview_id, body) belongs to user/preview
### Controllers
* Api::CommentsController (create, new, destroy)
### Views

## Backbone
### Models
* Comment
### Collections
* Comments
### Views
* CommentIndex composite with
* CommentShow subviews and
* CommentForm subview
* footer with comment button and username in PreviewShow
## Gems/Libraries
