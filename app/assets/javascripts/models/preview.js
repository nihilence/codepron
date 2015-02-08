CodePron.Models.Preview = Backbone.Model.extend({
  urlRoot:'/api/previews',

  defaults:{
    html:"<p></p>",
    title: "A new project"
  }
})
