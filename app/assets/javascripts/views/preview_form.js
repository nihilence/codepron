CodePron.Views.PreviewForm = Backbone.CompositeView.extend({
  template: JST['previews/form'],

  events:{
    "keypress": "saveModel",
    "click .submit": "saveModel"
  },

  initialize: function(){
    this.listenTo(this.model, "sync", this.render);

  },

  render: function(){
    var that = this;
    var htmlCase = $('<div></div>');
    this.$el.html(this.template({preview: this.model}));

    return this;
  },

  renderPreview: function(){
      var preview = new CodePron.Views.PreviewShow({model: this.model})
      this.addSubview('.iframe', preview);
  },

  saveModel: function(event, ui){
    if(event.type === 'click' || event.keyCode === 92 ){
      event.preventDefault();
      var form = this;
      form.model.save({
        css:$('#css').val(),
        html:$('#html').val(),
        js:$('#js').val()
      },
    {
      success: function(model){
        CodePron.previews.add(model, {merge: true})
        CodePron.previews.fetch()
      }
    })
    };

  }

});
