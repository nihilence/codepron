CodePron.Views.PreviewForm = Backbone.View.extend({
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
    this.$el.html(this.template({preview: this.model}));
    return this;
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
      },


    }) 
    };

  }

});
