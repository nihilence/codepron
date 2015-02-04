CodePron.Views.PreviewShow = Backbone.View.extend({
  template: JST['previews/previewShow'],

  iframeCon: function(region){
    return $('.iframe').contents().find(region);
  },

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);
  },

  setCss: function(){
    var content = this.model.get('css');
    this.iframeCon('head').empty();
    this.iframeCon('head').append('<style>'+content+'</style>');
    return this;
  },


  render: function(){
    this.iframeCon('body').html(this.template({preview: this.model}));
    this.setCss();
    this.setJs();
    return this;
  },

  renderForm: function(){
    var formView = new CodePron.Views.PreviewForm({model: this.model});
    return this;
  },

  setJs: function(){
    var content = this.model.get('js');
    $('#main').append('<script>'+ content + '</script>')
  }

});
