CodePron.Models.Preview = Backbone.Model.extend({
  urlRoot:'/api/previews',

  defaults:{
    html:"<p></p>",
    title: "A new project"
  },

  author: function () {
    if (!this._author) {
      this._author = CodePron.users.getOrFetch(this.get('author_id'));
    }
    return this._author;
  },

  parse: function (response) {
    if (response.author) {
      this.author().set(response.author);
      delete response.author;
    }

    return response;
  }
})
