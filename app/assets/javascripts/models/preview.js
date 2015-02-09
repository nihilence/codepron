CodePron.Models.Preview = Backbone.Model.extend({
  urlRoot:'/api/previews',

  defaults:{
    html:"<p></p>",
    title: "A new project"
  },

  author: function () {
    if (!this._author) {
      this._author = CodePron.users.getOrFetch({id:this.get('author_id')});
    }
    return this._author;
  },

  parse: function (response) {

    if (response.author) {
      this.author().set(response.author, { parse: true });
      delete response.author;
    }

    return response;
  }
})
