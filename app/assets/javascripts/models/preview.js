CodePron.Models.Preview = Backbone.Model.extend({
  urlRoot:'/api/previews',

  defaults:{
    html:"<p></p>",
    title: "A new project"
  },

  comments: function () {
    if (!this._comments) {
      this._comments = new CodePron.Collections.Comments([], {preview: this});
    }
    return this._comments;
  },

  parse: function (response) {
    if (response.comments) {
      this.comments().set(response.comments, {parse: true});
      delete response.comments;
    }

    return response;
  },

})
