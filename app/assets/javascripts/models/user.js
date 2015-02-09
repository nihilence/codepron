CodePron.Models.User = Backbone.Model.extend({
  urlRoot: 'users/',

  previews: function () {
    if (!this._previews) {
      this._previews = new CodePron.Collections.Previews([], { board: this });
    }
    return this._previews;
  },

  parse: function (response) {
    if (response.previews) {
      this.previews().set(response.previews, { parse: true });
      delete response.previews;
    }

    return response;
  }
})
