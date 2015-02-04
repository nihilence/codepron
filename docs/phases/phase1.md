# Phase 1: Show Page for Preview

## Rails
### Models
* Preview(title, description, author_id, html, css, js, combined)

### Controllers
* Api Controller
* Static Pages Controller
* Api::PreviewsController (show, update)

### Views
* static_pages/root.html.erb
* api/previews/show.json.jbuilder

## Backbone
* previews_router.js
### Models
* preview.js
### Collections
* previews.js
### Views
* views/previews/show.js
* templates/previewShow.js
* templates/previewForm.js
* javascripts/utils/composite_view.js
* remember to require tree ./utils in application.js
## Gems/Libraries
