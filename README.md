# CodeProN - Code Previews on Rails!

[Heroku link][heroku]

[heroku]: http://codepron.herokuapp.com

## Minimum Viable Product
CodeProN is a clone of CodePen built on Rails and Backbone. Users can:

- [X] Create accounts
- [X] Create sessions (log in)
- [X] Create previews
- [X] Preview HTML/CSS/JS in real time
- [X] View index of previews
- [X] View individual previews
- [ ] Users can follow each other
- [X] Users can comment on previews

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: Show Page for Preview (~2 days)
I will implement an iframe to show the preview with one HTML textarea field.
Once that is working I will add the other two in slowly. I need to grab the
appropriate data from each field in the database to fill each textarea. Each
field should send an AJAX PUT request on "enter" and update the database table,
the textareas and the iframe. The server will combine all of the textareas to
fill the iframe. This will include JSON API and Backbone Views.

[Details][phase-one]

### Phase 2: Index, Create and Nav Bar (~2 days)
The root page should be the index of the code previews. It should display a
thumbnail of the preview window and the title. The create button should make
a new code preview in the database and direct to the show page. The author_id
in the previews table can be blank so anonymous users can generate code
previews.The Nav bar will have a button to sign in/sign up, logo links home,
display the user's profile and search previews bar.

[Details][phase-two]

### Phase 3: User Authentication and Associations (~2 days)
Authentication will be implemented manually using the process taught by App
Academy. A user will be able to log in/out, visit his/her profile which will
include their few most recent previews, a display image, large user name and
links to personal websites like github/blogs, followers, following, follow
button. Show avatar in corner, dropdown menu for profile/settings/help/logout.
I will integrate with Filepicker for image sizing.
[Details][phase-three]

### Phase 4: Comments on previews (~2 days)
I will need a comment model to store user's comments on previews. It will have
both user_id and preview_id fields as well as a body. The comment button will
pop up a comment window over the preview window and allow users to submit, read
or delete comments. Users shouldn't be able to delete another's comments.
[Details][phase-four]


### Phase 5: User Follows (~1 days)
I'll start with a table joining a follower's id with a followed user's id which
will require a follow model and controller. The button on the user show
page will show Unfollow if a user is already followed and Follow if not. The
button will work with AJAX requests to render the change while the request to
the server is sent in the background. When clicked, followers or followed users
will appear on user show page. Reactive preview search will also be implemented.

[Details][phase-five]

### Bonus Features (TBD)
- [ ] Fork option
- [ ] Option for JS library inclusion
- [ ] Tagging, search by tag
- [ ] 'Heart' button and counter for `PreviewShow` view
- [ ] Pagination of previews index
- [ ] Buttons to change position of textareas and preview
- [ ] Hotkey map and bindings
- [ ] Blogs
- [ ] Clicks count

[phase-one]: ./docs/phases/phase1.md
[phase-two]: ./docs/phases/phase2.md
[phase-three]: ./docs/phases/phase3.md
[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md
