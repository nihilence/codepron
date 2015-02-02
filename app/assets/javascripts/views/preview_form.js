PronTest.Views.PreviewForm = Backbone.CompositeView.extend({
  template: JST['previews/form'],

  events:{
    "keydown textarea":"sendForm"
  },

  initialize: function(){
    this.collection = this.subviews;
    this.listenTo(this.model, "sync", this.render);

  },

  render: function(){
    this.renderPreview();
    var renderedContent = this.template({preview: this.model});
    this.$el.html(renderedContent);

    return this;
  },

  renderPreview: function(){
      var preview = new PronTest.Views.PreviewShow({model: this.model})
      this.addSubview('.iframe', preview);
  },

  sendForm: function(event){
    if(event.keyCode === 13){
      this.model.save({html_input: this.$('textarea').val()})
    }
    this.$('textarea').focus();

  },

  create: function (event) {
    event.preventDefault();
    console.log(this.model);
    this.$('textarea').val('');
    this.$('textarea').focus();
  }

});
